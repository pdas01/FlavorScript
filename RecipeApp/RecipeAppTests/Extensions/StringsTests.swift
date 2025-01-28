import XCTest
@testable import RecipeApp

final class StringsTests: XCTestCase {
    func testYoutubeVideoIdNotNil() {
        let actualURL = "https://www.youtube.com/watch?v=5ZYWVQ8imVA"
        let expectedVideoId = "5ZYWVQ8imVA"
        let actualVideoId = actualURL.youtubeVideoId()
        XCTAssertEqual(actualVideoId, expectedVideoId)
    }

    func testYoutubeVideoIdNil() {
        let actualURL = "https://www.bbcgoodfood.com/recipes/13354/jam-rolypoly"
        let expectedVideoId: String? = nil
        let actualVideoId = actualURL.youtubeVideoId()
        XCTAssertEqual(actualVideoId, expectedVideoId)
    }
}
