import SwiftUI

struct RecipesTab: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: .zero) {
                    Spacer().frame(height: DesignConstants.spacing32)
                    switch viewModel.viewState {
                    case .loading:
                        RecipeCardLoadingView()
                    case .empty:
                        Text(AppStrings.Error.noRecipesFound.value)
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                    case .someContent:
                        FilterCuisine(cuisineType: $viewModel.cusineType)
                        let recipes = viewModel.cusineType == .all ? viewModel.recipes ?? [] : viewModel.filteredRecipes ?? []
                        ForEach(recipes, id: \.uuid) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCard(recipe: recipe)
                            }
                            Spacer().frame(height: DesignConstants.spacing8)
                        }
                    case .error:
                        Text(viewModel.errorMessage ?? "")
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, DesignConstants.padding16)
                .padding(.vertical, DesignConstants.padding16)
            }
            .onChange(of: viewModel.cusineType) { newValue in
                viewModel.cuisineChanged()
            }
            .task {
                await viewModel.fetchAllRecipes()
            }
            .refreshable {
                await viewModel.fetchAllRecipes()
            }
        }
    }
}

extension RecipesTab {
    struct FilterCuisine: View {
        @Binding var cuisineType: ViewModel.CuisineType
        var body: some View {
            HStack {
                Spacer()
                Picker("", selection: $cuisineType) {
                    ForEach(ViewModel.CuisineType.allCases, id: \.self) { cuisine in
                        Text(String(cuisine.rawValue.prefix(1)).capitalized + cuisine.rawValue.dropFirst())
                            .font(.title3)
                    }
                }
                .pickerStyle(.menu)
                .scaleEffect(1.0)
                .accentColor(.black)
            }
        }
    }
}


fileprivate struct DesignConstants {
    static let spacing4: CGFloat = 4.0
    static let spacing8: CGFloat = 8.0
    static let spacing32: CGFloat = 32.0
    static let padding16: CGFloat = 16.0
    enum RefreshButton {
        static let height: CGFloat = 32.0
    }
}
