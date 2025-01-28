import SwiftUI

/**
 ImageLoadingService class loads image from either cache disk or from the network 
 */
final class ImageLoadingService: ObservableObject {
    @Published var image: Image? = nil
    private let cacheDiskManager = CacheDiskManager.shared
    
    private func loadFromNetwork(url: URL) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return data
        } catch {
            debugPrint("Error when fetching image from server", error.localizedDescription)
        }
        return nil
    }

    func cacheKey(url: URL) -> String? {
        let pathComponents = url.pathComponents
        guard pathComponents.count > 3 else { return nil }
        let uuidString = pathComponents[pathComponents.count - 2]
        // Extract small/large from the url
        let size = pathComponents[pathComponents.count - 1].split(separator: ".")[0]
        return "\(uuidString)_\(size)"
    }

    func loadImage(url: URL) async {
        // Fetch the unique image id from url
        guard let cacheKey = cacheKey(url: url) else {
            debugPrint("Error in getting unique image id from url")
            return
        }

        if let cachedImageData = cacheDiskManager.loadImage(cacheKey: cacheKey)  {
            let uiImage = UIImage(data: cachedImageData)
            if let uiImage = uiImage {
                await MainActor.run { [weak self] in
                    self?.image = Image(uiImage: uiImage)
                }
            }
        } else {
            // Fetch from network
            let imageData = await loadFromNetwork(url: url)
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                await MainActor.run { [weak self] in
                    self?.cacheDiskManager.saveImage(imageData: imageData, cacheKey: cacheKey)
                    self?.image = Image(uiImage: uiImage)
                }
            }
        }
    }
}

