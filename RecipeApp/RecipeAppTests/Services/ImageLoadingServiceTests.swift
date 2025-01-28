import XCTest
@testable import RecipeApp

final class ImageLoadingServiceTests: XCTestCase {
    var imageLoadingService: ImageLoadingService?
    
    override func setUp() {
        self.imageLoadingService = ImageLoadingService()
    }
    
    override func tearDown() {
        self.imageLoadingService = nil
    }
    
    func testCacheKeyNotNil() {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")!
        let expectedCacheKey = "535dfe4e-5d61-4db6-ba8f-7a27b1214f5d_large"
        let actualCacheKey = imageLoadingService?.cacheKey(url: url)
        XCTAssertEqual(expectedCacheKey, actualCacheKey)
    }
    
    func testCacheKeyNil() {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/large.jpg")!
        let expectedCacheKey: String? = nil
        let actualCacheKey = imageLoadingService?.cacheKey(url: url)
        XCTAssertEqual(expectedCacheKey, actualCacheKey)
    }
    
    func testLoadingImageSucceeded() async {
        guard let imageLoadingService = imageLoadingService else {
            return XCTFail("Could not unwrap ImageLoadingService")
        }
        XCTAssertNil(imageLoadingService.image)
        let imageURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg")!
        
        await imageLoadingService.loadImage(url: imageURL)
        XCTAssertNotNil(imageLoadingService.image)
        
        XCTAssertEqual(CacheDiskManager.shared.cacheDirectoryExists(), true)
        // Check file exits
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("RecipeImageCache", isDirectory: true)
        if let cacheURL = cacheURL {
            let filePath = cacheURL.appendingPathComponent("f4b7b7d7-9671-410e-bf81-39a007ede535_large")
            XCTAssertEqual(FileManager.default.fileExists(atPath: filePath.path), true)
            
        } else {
            XCTFail("Cache URL expected to exist")
        }
    }
    
    func testLoadingImageFailed() async {
        guard let imageLoadingService = imageLoadingService else {
            return XCTFail("Could not unwrap ImageLoadingService")
        }
        XCTAssertNil(imageLoadingService.image)
        let imageURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/large.jpg")!
        
        await imageLoadingService.loadImage(url: imageURL)
        XCTAssertNil(imageLoadingService.image)
    }
}
