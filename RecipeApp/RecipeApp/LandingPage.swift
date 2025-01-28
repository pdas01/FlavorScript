import SwiftUI

struct LandingPage: View {
    @State var activeTab: Int = 0
    var body: some View {
        TabView {
            RecipesTab()
                .tabItem {
                    Label(AppStrings.Common.recipes.value, systemImage: SystemImageConstants.recipesIcon)
                }
            SettingsView()
                .tabItem {
                    Label(AppStrings.Common.settings.value, systemImage: SystemImageConstants.settingsIcon)
                }
        }.accentColor(.purple)
    }
}

#Preview {
    LandingPage()
}
