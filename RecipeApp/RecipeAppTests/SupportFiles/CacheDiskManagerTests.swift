import XCTest
@testable import RecipeApp


final class CacheDiskManagerTests: XCTestCase {

    var tempCacheDir: URL!
    var cacheDiskManager: CacheDiskManager!
    let testKey = "testImage.jpg"
    let testImageData = "mock_image_data".data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        tempCacheDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: tempCacheDir, withIntermediateDirectories: true)
        cacheDiskManager = CacheDiskManager(cacheDirectory: tempCacheDir)
    }

    override func tearDownWithError() throws {
        try? FileManager.default.removeItem(at: tempCacheDir)
        tempCacheDir = nil
        cacheDiskManager = nil
        try super.tearDownWithError()
    }

    func testCacheDirectoryClear() async throws {
        await cacheDiskManager.saveImage(imageData: testImageData, cacheKey: testKey)
        // 'await' in an autoclosure that does not support concurrency
        let directoryExists = await cacheDiskManager.cacheDirectoryExists()
        XCTAssertTrue(directoryExists)
        
        // Clear the cache directory
        await cacheDiskManager.clearCacheDirectory()
        
        // Add a small delay to allow file system changes to propagate
        try await Task.sleep(nanoseconds: 500_000_000)  // Sleep for 0.5 seconds (adjust if

        let directoryExistsAfterClear = await cacheDiskManager.cacheDirectoryExists()
        XCTAssertFalse(directoryExistsAfterClear)
    }

    func testCacheDirectorySavesAndLoadsImage() async throws {
        await cacheDiskManager.saveImage(imageData: testImageData, cacheKey: testKey)
        let loadedData = await cacheDiskManager.loadImage(cacheKey: testKey)

        XCTAssertNotNil(loadedData)
        XCTAssertEqual(loadedData, testImageData)
    }
}
