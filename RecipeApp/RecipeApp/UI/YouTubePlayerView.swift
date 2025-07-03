import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    private let url: URL


    init?(videoID: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return nil }
        self.init(url: url)
    }

    init(url: URL) {
        self.url = url
    }

    func makeUIView(context: Context) -> WKWebView {
        // Potential memory leak here WKWebView retains itself  to its internal use of delegate and observer patterns. Need to up its navigation delegate or stop loading, it may linger in memory.
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Load only when needed
        if uiView.url != url {
            uiView.stopLoading()
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    // MARK: - Coordinator

       func makeCoordinator() -> Coordinator {
           Coordinator()
       }

       class Coordinator: NSObject, WKNavigationDelegate {
           deinit {
               print("Coordinator deinitialized")
           }

           func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
               print("WebView finished loading")
           }

           // Add error handling, loading progress, etc.
       }
}

