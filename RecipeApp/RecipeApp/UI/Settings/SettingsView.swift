import SwiftUI

struct SettingsView: View {
    @State private var responseType: ResponseType
    
    init() {
        self.responseType = ResponseType(rawValue: UserSettings.recipe) ?? .success
    }
    enum ResponseType: String, CaseIterable {
        case success = "Success"
        case malformed = "Malformed"
        case empty = "Empty"
    }
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Developer Settings")) {
                    Picker("Response Type", selection: $responseType) {
                        ForEach(ResponseType.allCases, id: \.self) { value in
                            Text(value.rawValue)
                        }
                    }
                    .onChange(of: responseType) { newValue in
                        // Update UserDefaults
                        UserDefaults.standard.set(newValue.rawValue, forKey: "recipe_response")
                    }
                    .pickerStyle(.menu)
                    Button("Clear Image Caches") {
                        Task {
                           await  CacheDiskManager.shared.clearCacheDirectory()
                        }
                        
                    }
                }
                .tint(.black)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(AppStrings.Common.settings.value)
        }
    }
}

#Preview {
    SettingsView()
}
