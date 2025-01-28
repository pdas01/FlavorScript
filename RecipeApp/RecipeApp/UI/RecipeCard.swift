import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    var body: some View {
        HStack(alignment: .top) {
            RemoteImage(imageString: recipe.photoUrlSmall ?? "")
                .cornerRadius(DesignConstants.Image.cornerRadius)
                .frame(width: DesignConstants.Image.width, height: DesignConstants.Image.height)
            VStack(alignment: .leading, spacing: .zero) {
                Text(recipe.name)
                    .font(.headline)
                    .bold()
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .foregroundColor(.black)
        .padding(.all, DesignConstants.padding8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: DesignConstants.Card.cornerRadius)
                .fill(.gray.opacity(DesignConstants.Card.bgOpacity))
        )
    }
}

#Preview {
    RecipeCard(recipe: PreviewData.recipeData)
        .padding(.horizontal, 16)
}

fileprivate struct DesignConstants {
    static let padding4: CGFloat = 4.0
    static let padding8: CGFloat = 8.0

    enum Image {
        static let height: CGFloat = 80.0
        static let width: CGFloat = 80.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    enum Card {
        static let cornerRadius: CGFloat = 8.0
        static let bgOpacity: CGFloat = 0.1
    }
}
