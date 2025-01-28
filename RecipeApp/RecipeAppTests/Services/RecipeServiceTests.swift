import XCTest
@testable import RecipeApp

final class RecipeServiceTests: XCTestCase {
    var recipeService: RecipeService?

    override func setUp() {
        self.recipeService = RecipeService()
    }
    
    override func tearDown() {
        self.recipeService = nil
    }

    func testFetchRecipes() async throws {
        guard let recipeService = recipeService else { return XCTFail("Failed to setup recipe service")}
        
        let response = try await recipeService.fetchRecipes("AllRecipesResponse")
        XCTAssertNotNil(response?.recipes)
    }
    
}
