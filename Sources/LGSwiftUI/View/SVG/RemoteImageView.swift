///*
// Upload and Display SVG
// */

import SwiftUI
import WebKit

public struct RemoteImageView: View {
    public let url: URL?
    public var width: CGFloat?
    public var height: CGFloat?
    public var fill: Bool
    public var loaderTint: Color
    public var timeout: TimeInterval
    
    @State private var uiImage: UIImage?
    @State private var svgData: Data?
    @State private var errorMessage: String?
    @State private var isLoading = true
    
    public init(
        url: URL?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        fill: Bool = false,
        loaderTint: Color = .blue,
        timeout: TimeInterval = 10
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.fill = fill
        self.loaderTint = loaderTint
        self.timeout = timeout
    }
    
    public var body: some View {
        Group {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: fill ? .fill : .fit)
                    .clipped()
                
            } else if let svgData = svgData {
                SVGView(svgData: svgData, fill: fill)
                
            } else if errorMessage != nil {
                TimedTextView(size: width ?? 10)
            } else if isLoading {
                LoaderView(tint: loaderTint)
            }
        }
        .frame(width: width, height: height)
        .task { await loadWithTimeout() }
    }
}

// MARK: - Chargement avec TaskGroup + cancelAll

private extension RemoteImageView {
    
    enum Outcome {
        case svg(Data)
        case bitmap(UIImage)
        case failure(String)
        case timeout
    }
    
    func loadWithTimeout() async {
        guard let url else {
            await MainActor.run {
                errorMessage = "URL invalide"
                isLoading = false
            }
            return
        }
        
        await MainActor.run {
            // reset éventuel
            uiImage = nil
            svgData = nil
            errorMessage = nil
            isLoading = true
        }
        
        await withTaskGroup(of: Outcome.self) { group in
            // Tâche 1 : téléchargement
            group.addTask {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    if Task.isCancelled { throw CancellationError() }
                    
                    let mime = (
                        (response as? HTTPURLResponse)?
                            .value(forHTTPHeaderField: "Content-Type")?
                            .lowercased()
                        ?? response.mimeType?.lowercased()
                        ?? ""
                    )
                    
                    if mime.contains("image/svg+xml") {
                        return .svg(data)
                    } else if let image = UIImage(data: data) {
                        return .bitmap(image)
                    } else {
                        return .failure("Format non supporté (mime: \(mime))")
                    }
                } catch is CancellationError {
                    // Annulé par le timeout → ne renvoie rien d’utile
                    return .failure("Opération annulée")
                } catch {
                    return .failure("Erreur réseau : \(error.localizedDescription)")
                }
            }
            
            // Tâche 2 : timeout
            group.addTask {
                try? await Task.sleep(for: .seconds(timeout))
                if Task.isCancelled { return .failure("Annulé") }
                return .timeout
            }
            
            // On prend le PREMIER résultat qui tombe, puis on annule l'autre
            if let first = await group.next() {
                await MainActor.run {
                    switch first {
                    case .svg(let data):
                        svgData = data
                        isLoading = false
                        
                    case .bitmap(let image):
                        uiImage = image
                        isLoading = false
                        
                    case .failure(let message):
                        // Ne pas écraser un futur timeout, mais ici c’est le premier résultat
                        errorMessage = message
                        isLoading = false
                        
                    case .timeout:
                        errorMessage = "Temps dépassé (>\(Int(timeout))s)"
                        isLoading = false
                    }
                }
                
                // 🛑 Annule toutes les autres tâches encore en cours (timeout ou download)
                group.cancelAll()
            }
            
            // Draine proprement les résultats restants (nécessaire pour terminer le group)
            for await _ in group { /* no-op */ }
        }
    }
}

// MARK: - SVG

struct SVGView: UIViewRepresentable {
    let svgData: Data
    let fill: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let wv = WKWebView()
        wv.scrollView.isScrollEnabled = false
        wv.isOpaque = false
        wv.backgroundColor = .clear
        return wv
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let svgString = String(data: svgData, encoding: .utf8) else { return }
        let objectFit = fill ? "cover" : "contain"
        let html = """
        <html>
        <head>
          <meta name="viewport" content="initial-scale=1.0" />
          <style>
            html, body { margin:0; padding:0; background:transparent; width:100%; height:100%; overflow:hidden; }
            svg { width:100%; height:100%; object-fit:\(objectFit); }
          </style>
        </head>
        <body>\(svgString)</body>
        </html>
        """
        uiView.loadHTMLString(html, baseURL: nil)
    }
}

struct TimedTextView: View {
    @State private var showText = false
    var size: CGFloat
    var body: some View {
        VStack {
            if showText {
                VStack {
                    Image(systemName: "exclamationmark.circle")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .yellow)
                        .font(.system(size: size))
                }
            }
        }
        .task {
            await showTemporarily()
        }
        .animation(.easeInOut, value: showText)
    }
    
    func showTemporarily() async {
        await MainActor.run {
            showText = true
        }
        
        // Attendre 2 secondes
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        
        await MainActor.run {
            withAnimation {
                showText = false
            }
        }
    }
}
