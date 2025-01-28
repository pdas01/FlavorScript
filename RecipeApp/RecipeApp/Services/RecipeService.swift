import Foundation

/**
 RecipeService is a service that calls networkmanager 
 */
final class RecipeService {
    private let networkManager = NetworkManager()

    func fetchRecipes(_ fileName: String) async throws -> RecipeList? {
        try await networkManager.recipes(Bundle.main.path(forResource: fileName, ofType: "json")!)
    }
}

