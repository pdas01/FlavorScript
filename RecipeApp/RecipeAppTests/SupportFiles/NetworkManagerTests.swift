import XCTest
@testable import RecipeApp

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchDataFromJsonSuccess() async {
        do {
            let data = try await networkManager.recipes(Bundle.main.path(forResource: "AllRecipesResponse", ofType: "json")!)
            XCTAssertNotNil(data)
        } catch {
            XCTFail("Expected successful response, but got error: \(error.localizedDescription)")
        }
    }
    
    func testFetchDataFromJsonWithMalformedResponse() async {
        var catchBlockReached = false
        do {
            _ = try await networkManager.recipes(Bundle.main.path(forResource: "MalformedResponse", ofType: "json")!)
            XCTFail("Expected decoding error but response succeeded")
        } catch {
            catchBlockReached = true
        }
        XCTAssertTrue(catchBlockReached)
    }
    
    func testFetchDataFromJsonWithEmptyResponse() async {
        do {
            let recipeList = try await networkManager.recipes(Bundle.main.path(forResource: "EmptyResponse", ofType: "json")!)
            XCTAssertNotNil(recipeList?.recipes)
            XCTAssertTrue(recipeList?.recipes.isEmpty == true)
        } catch {
            XCTFail("Expected to succeeed but got error instead \(error.localizedDescription)")
        }
    }
    
}

