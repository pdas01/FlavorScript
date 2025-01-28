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
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

