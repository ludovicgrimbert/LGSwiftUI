//
//  SnapshotAssert.swift
//  LGSwiftUITests
//
//  Dependency-free snapshot testing built on SwiftUI's `ImageRenderer`.
//
//  - Reference PNGs live next to the tests, in `__Snapshots__/`, and are committed.
//  - A missing reference is recorded and the test fails once (so a first run can
//    never silently pass). Run again to compare against what was just recorded.
//  - Set `RECORD_SNAPSHOTS=1` in the test process environment to re-record everything
//    (with xcodebuild on a simulator: `SIMCTL_CHILD_RECORD_SNAPSHOTS=1 xcodebuild test …`).
//  - On mismatch, the freshly rendered image is written to `__Snapshots__/.failures/`
//    (git-ignored) so it can be compared with the reference by eye.
//

import SwiftUI
import Testing
import UIKit

@MainActor
func assertSnapshot(
    of view: some View,
    named name: String,
    size: CGSize,
    precision: Double = 0.995,
    channelTolerance: UInt8 = 8,
    fileID: String = #fileID,
    filePath: String = #filePath,
    line: Int = #line,
    column: Int = #column
) {
    let sourceLocation = SourceLocation(fileID: fileID, filePath: filePath, line: line, column: column)
    let snapshotsDirectory = URL(fileURLWithPath: filePath)
        .deletingLastPathComponent()
        .appendingPathComponent("__Snapshots__", isDirectory: true)
    let referenceURL = snapshotsDirectory.appendingPathComponent("\(name).png")
    let failuresDirectory = snapshotsDirectory.appendingPathComponent(".failures", isDirectory: true)

    let renderer = ImageRenderer(content: view.frame(width: size.width, height: size.height))
    renderer.scale = 2
    renderer.proposedSize = ProposedViewSize(size)

    guard let rendered = renderer.uiImage, let renderedPNG = rendered.pngData() else {
        Issue.record("Could not render '\(name)'", sourceLocation: sourceLocation)
        return
    }

    let isRecording = ProcessInfo.processInfo.environment["RECORD_SNAPSHOTS"] == "1"
    let referenceExists = FileManager.default.fileExists(atPath: referenceURL.path)

    if isRecording || !referenceExists {
        do {
            try FileManager.default.createDirectory(at: snapshotsDirectory, withIntermediateDirectories: true)
            try renderedPNG.write(to: referenceURL, options: .atomic)
        } catch {
            Issue.record("Could not write reference for '\(name)': \(error)", sourceLocation: sourceLocation)
            return
        }
        Issue.record(
            "Recorded reference snapshot '\(name)' at \(referenceURL.path). Re-run to compare against it.",
            sourceLocation: sourceLocation
        )
        return
    }

    guard let reference = UIImage(contentsOfFile: referenceURL.path) else {
        Issue.record("Could not load reference for '\(name)' at \(referenceURL.path)", sourceLocation: sourceLocation)
        return
    }

    let outcome = compare(reference, rendered, channelTolerance: channelTolerance)
    switch outcome {
    case .sizeMismatch(let expected, let actual):
        writeFailure(renderedPNG, name: name, in: failuresDirectory)
        Issue.record(
            "Snapshot '\(name)' size changed: reference \(expected) vs rendered \(actual). Rendered image saved in \(failuresDirectory.path).",
            sourceLocation: sourceLocation
        )
    case .matched(let matchingFraction):
        if matchingFraction < precision {
            writeFailure(renderedPNG, name: name, in: failuresDirectory)
            let percent = String(format: "%.3f", matchingFraction * 100)
            Issue.record(
                "Snapshot '\(name)' differs from reference: \(percent)% of pixels match (required \(precision * 100)%). Rendered image saved in \(failuresDirectory.path).",
                sourceLocation: sourceLocation
            )
        }
    }
}

// MARK: - Comparison

private enum ComparisonOutcome {
    case sizeMismatch(expected: CGSize, actual: CGSize)
    case matched(fraction: Double)
}

/// Redraws both images through the same RGBA8 context so colour space and byte
/// order never influence the comparison, then counts pixels whose largest channel
/// difference exceeds `channelTolerance`.
private func compare(_ reference: UIImage, _ candidate: UIImage, channelTolerance: UInt8) -> ComparisonOutcome {
    guard
        let referencePixels = rgbaPixels(of: reference),
        let candidatePixels = rgbaPixels(of: candidate)
    else {
        return .sizeMismatch(expected: reference.size, actual: candidate.size)
    }
    guard referencePixels.width == candidatePixels.width, referencePixels.height == candidatePixels.height else {
        return .sizeMismatch(
            expected: CGSize(width: referencePixels.width, height: referencePixels.height),
            actual: CGSize(width: candidatePixels.width, height: candidatePixels.height)
        )
    }

    let pixelCount = referencePixels.width * referencePixels.height
    var differing = 0
    var index = 0
    while index < referencePixels.bytes.count {
        let dr = referencePixels.bytes[index].distance(to: candidatePixels.bytes[index])
        let dg = referencePixels.bytes[index + 1].distance(to: candidatePixels.bytes[index + 1])
        let db = referencePixels.bytes[index + 2].distance(to: candidatePixels.bytes[index + 2])
        let da = referencePixels.bytes[index + 3].distance(to: candidatePixels.bytes[index + 3])
        if max(abs(dr), abs(dg), abs(db), abs(da)) > Int(channelTolerance) {
            differing += 1
        }
        index += 4
    }
    return .matched(fraction: 1 - Double(differing) / Double(pixelCount))
}

private struct RGBAPixels {
    let width: Int
    let height: Int
    let bytes: [UInt8]
}

private func rgbaPixels(of image: UIImage) -> RGBAPixels? {
    guard let cgImage = image.cgImage else { return nil }
    let width = cgImage.width
    let height = cgImage.height
    var bytes = [UInt8](repeating: 0, count: width * height * 4)
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    let drawn = bytes.withUnsafeMutableBytes { buffer -> Bool in
        guard let context = CGContext(
            data: buffer.baseAddress,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: bitmapInfo
        ) else { return false }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return true
    }
    return drawn ? RGBAPixels(width: width, height: height, bytes: bytes) : nil
}

private func writeFailure(_ png: Data, name: String, in directory: URL) {
    try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    try? png.write(to: directory.appendingPathComponent("\(name).png"), options: .atomic)
}
