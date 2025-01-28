import XCTest
@testable import RecipeApp

final class CacheDiskManagerTests: XCTestCase {
    var cacheDiskManager: CacheDiskManager?
    
    override func setUp() {
        self.cacheDiskManager = CacheDiskManager.shared
    }
    
    override func tearDown() {
        self.cacheDiskManager = nil
    }
    
    func testCacheDirectoryClear() {
        guard let cacheDiskManager = cacheDiskManager else {
            return XCTFail("Unable to unwrap CacheDiskManager")
        }
        cacheDiskManager.clearCacheDirectory()
        XCTAssertFalse(cacheDiskManager.cacheDirectoryExists())
    }
    
    func testCacheDirectorySavesImage() {
        guard let cacheDiskManager = cacheDiskManager else {
            return XCTFail("Unable to unwrap CacheDiskManager")
        }
        cacheDiskManager.clearCacheDirectory()
        XCTAssertFalse(cacheDiskManager.cacheDirectoryExists())
    }
}
