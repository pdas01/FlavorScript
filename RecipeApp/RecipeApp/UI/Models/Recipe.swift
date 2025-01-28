import SwiftUI

struct Recipe: Codable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let uuid: String
    let youtubeUrl: String?
}

struct RecipeList: Codable {
    let recipes: [Recipe]
}
