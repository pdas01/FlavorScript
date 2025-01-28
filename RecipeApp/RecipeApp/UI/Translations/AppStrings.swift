import Foundation

enum AppStrings {
    enum Error {
        case noRecipesFound
        case genericServerError
        var value: String {
            switch self {
            case .noRecipesFound:
                LocalizedString.Error.no_recipes_found
            case .genericServerError:
                LocalizedString.Error.generic_server_error
            }
        }
    }
    
    enum Common {
        case cuisine
        case recipes
        case allRecipes
        case fullRecipe
        case refresh
        case settings
        var value: String {
            switch self {
            case .cuisine:
                LocalizedString.Common.cuisine
            case .recipes:
                LocalizedString.Common.recipes
            case .allRecipes:
                LocalizedString.Common.all_recipes
            case .fullRecipe:
                LocalizedString.Common.full_recipe
            case .refresh:
                LocalizedString.Common.refresh
            case .settings:
                LocalizedString.Common.settings
            }
        }
    }
}

enum LocalizedString {
    enum Error {
        static let no_recipes_found = NSLocalizedString("no_recipes_found", value: "No recipes are available.", comment: "No recipes found")
        static let generic_server_error = NSLocalizedString("generic_server_error", value: "Ooops! Something went wrong. Please try again later.", comment: "Generic server error")
    }
    enum Common {
        static let cuisine = NSLocalizedString("cuisine", value: "Cuisine", comment: "Cuisine")
        static let recipes = NSLocalizedString("recipes", value: "Recipes", comment: "Recipes")
        static let all_recipes = NSLocalizedString("all_recipes", value: "All Recipes", comment: "All recipes")
        static let full_recipe = NSLocalizedString("full_recipe", value: "Full Recipe", comment: "Full recipe")
        static let refresh = NSLocalizedString("refresh", value: "Refresh", comment: "Refresh")
        static let settings = NSLocalizedString("settings", value: "Settings", comment: "Settings")
    }
    
}
