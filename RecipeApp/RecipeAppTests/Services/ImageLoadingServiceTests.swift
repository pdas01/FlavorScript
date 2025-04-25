import XCTest
@testable import RecipeApp


final class ImageLoadingServiceTests: XCTestCase {
    var imageLoadingService: ImageLoadingService!
    var mockSession: MockNetworkSession!
    
    @MainActor
    override func setUp() {
        mockSession = MockNetworkSession()
        imageLoadingService = ImageLoadingService(session: mockSession)
    }

    override func tearDown() {
        imageLoadingService = nil
        mockSession = nil
    }

    @MainActor func testCacheKeyNotNil() {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")!
        let expectedCacheKey = "535dfe4e-5d61-4db6-ba8f-7a27b1214f5d_large"
        let actualCacheKey = imageLoadingService.cacheKey(url: url)
        XCTAssertEqual(expectedCacheKey, actualCacheKey)
    }

    func testCacheKeyNil() async {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/large.jpg")!
        // await MainActor.run ensures that the code is run asynchronously in the proper context (main thread)
        let cacheKey = await MainActor.run {
                imageLoadingService.cacheKey(url: url)
            }
            
        XCTAssertNil(cacheKey)
    }

    func testLoadingImageSucceeded() async {
        let testImage = UIImage(systemName: "photo")!
        mockSession.mockData = testImage.pngData()

        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg")!
        
        // Ensure image is nil before loading
        await MainActor.run {
            XCTAssertNil(imageLoadingService.image)
        }
        
        // Load image
        await imageLoadingService.loadImage(url: url)

        // Verify the image was loaded
        await MainActor.run {
            XCTAssertNotNil(imageLoadingService.image)
        }

        let cacheKey = "f4b7b7d7-9671-410e-bf81-39a007ede535_large"
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("RecipeImageCache")
            .appendingPathComponent(cacheKey)

        XCTAssertTrue(FileManager.default.fileExists(atPath: cacheURL!.path))
    }

    func testLoadingImageFailed() async {
        mockSession.shouldThrowError = true

        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/invalid.jpg")!
        // Ensure image is nil before loading
        await MainActor.run {
            XCTAssertNil(imageLoadingService.image)
        }

        // Load image
        await imageLoadingService.loadImage(url: url)

        // Verify image is still nil due to error
        await MainActor.run {
            XCTAssertNil(imageLoadingService.image)
        }
    }
}
