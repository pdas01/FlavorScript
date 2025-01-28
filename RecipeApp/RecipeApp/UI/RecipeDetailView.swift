import SwiftUI
import AVKit

struct RecipeDetailView: View {
    @Environment(\.openURL) var openURL
    let recipe: Recipe
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: DesignConstants.padding8) {
                RemoteImage(imageString: recipe.photoUrlLarge ?? "")
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .top)
                VStack {
                    Spacer()
                    Text(recipe.name)
                        .font(.title)
                        .bold()
                    Text("\(AppStrings.Common.cuisine.value): \(recipe.cuisine)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Divider()
                    Button(action: {
                        if let sourceUrl = recipe.sourceUrl, let url = URL(string: sourceUrl) {
                            openURL(url)
                        }
                    }) {
                        Label(AppStrings.Common.fullRecipe.value, systemImage: SystemImageConstants.recipesIcon)
                            .font(.headline)
                            .padding(.all, DesignConstants.padding8)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(.purple)
                            .cornerRadius(DesignConstants.Button.cornerRadius)
                    }
                    Spacer().frame(height: DesignConstants.spacing32)
                    if let videoStr = recipe.youtubeUrl,
                       let videoID = videoStr.youtubeVideoId() {
                        YouTubePlayerView(videoID: videoID)
                            .frame(width: DesignConstants.YoutubePlayer.width, height: DesignConstants.YoutubePlayer.height)
                    }
                    Spacer()
                }.padding(.horizontal, DesignConstants.padding16)
            }
        }
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(recipe.name)
            }
        }
    }
}

fileprivate struct DesignConstants {
    static let padding8: CGFloat = 8.0
    static let padding16: CGFloat = 16.0
    static let spacing32: CGFloat = 32.0
    
    enum Button {
        static let cornerRadius: CGFloat = 10.0
    }
    
    enum YoutubePlayer {
        static let width: CGFloat = 300
        static let height: CGFloat = 300
    }
}

#Preview {
    RecipeDetailView(recipe: PreviewData.recipeData)
       
}
