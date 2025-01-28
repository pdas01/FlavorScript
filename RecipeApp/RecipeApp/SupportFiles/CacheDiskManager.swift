import SwiftUI

/**
 CacheDiskManager saves and loads image data to and from the cache disk
 */
final class CacheDiskManager {
    static let shared = CacheDiskManager()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let cacheDirectoryName: String = "RecipeImageCache"
    
    private init() {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        cacheDirectory = cachePath.appendingPathComponent(cacheDirectoryName, isDirectory: true)
    }
    
    func cacheDirectoryExists() -> Bool {
        fileManager.fileExists(atPath: cacheDirectory.path)
    }

    func clearCacheDirectory() {
        guard cacheDirectoryExists() else { return }
        do {
            try fileManager.removeItem(at: cacheDirectory)
        } catch {
            debugPrint("Error in deleting cache directory :\(cacheDirectory) of file \(error.localizedDescription)")
        }
    }

    func saveImage(imageData: Data?, cacheKey: String) {
        // Check if directory exits otherwise create new directory
        if !cacheDirectoryExists() {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
        let fileURL = cacheDirectory.appendingPathComponent(cacheKey)

        if let imageData = imageData {
            try? imageData.write(to: fileURL)
        }
    }
    
    func loadImage(cacheKey: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(cacheKey)
        guard cacheDirectoryExists() && fileManager.fileExists(atPath: fileURL.path) else {
            debugPrint("Cache does not exist. Load from network.")
            return nil
        }
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            debugPrint("Error in loading imageData from cache file \(error.localizedDescription)")
        }
        return nil
    }
    
    
}
