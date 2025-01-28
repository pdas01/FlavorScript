import Foundation

class UserSettings {
    static var recipe: String {
        let recipe_response = UserDefaults.standard.string(forKey: "recipe_response") ?? "Success"
        return recipe_response
    }
}
