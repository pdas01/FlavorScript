import SwiftUI

extension RecipesTab {
    class ViewModel: ObservableObject {
        @Published var recipes: [Recipe]? = nil
        @Published var errorMessage: String? = nil
        @Published var cusineType: CuisineType = .all
        @Published var filteredRecipes: [Recipe]? = nil
        let recipeService = RecipeService()
        var viewState: ViewState {
            if recipes?.isEmpty == true {
                return .empty
            } else if errorMessage != nil {
                return .error
            } else if recipes != nil {
                return .someContent
            } else {
                return .loading
            }
        }
        
        enum ViewState {
            case loading
            case empty
            case someContent
            case error
        }
        
        enum CuisineType: String, CaseIterable {
            case all = "All Recipes"
            case british
            case american
            case malaysian
            case italian
            case canadian
            case tunisian
            case french
            case polish
            case portuguese
            case russian
        }
        
        func cuisineChanged()  {
            guard cusineType != .all else { return }
            filteredRecipes = recipes?.filter { $0.cuisine.lowercased() == cusineType.rawValue }
        }
        
        func reset() {
            self.errorMessage = nil
            self.recipes = nil
        }
        
        @MainActor
        func fetchAllRecipes() async {
            reset()
            do  {
                let response = try await recipeService.fetchRecipes(responseFileName)
                    self.recipes = response?.recipes
            } catch {
                self.errorMessage = AppStrings.Error.genericServerError.value
            }
        }
        
        var responseType: String {
            UserSettings.recipe
        }

        var responseFileName: String {
            switch responseType {
            case "Malformed":
                return "MalformedResponse"
            case "Empty":
                return "EmptyResponse"
            default:
                return "AllRecipesResponse"
            }
        }
    }
}
