import SwiftUI

struct RecipeCardLoadingView: View {
    var body: some View {
        VStack {
            ForEach(0..<5) {_ in
                RecipeCardLoading()
            }
        }
    }
}

struct RecipeCardLoading: View {
    @State private var isLoading = true
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isLoading)
                .foregroundColor(isLoading ? .gray: .gray.opacity(0.8))
                .frame(height: 130)
            Group {
                Rectangle()
                    .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isLoading)
                    .foregroundColor(isLoading ? .gray: .gray.opacity(0.8))
                    .frame(width: 150, height: 10)
                Rectangle()
                    .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isLoading)
                    .foregroundColor(isLoading ? .gray: .gray.opacity(0.8))
                    .frame(width: 100, height: 10)
            }
            .padding(.leading, 4)
            .padding(.bottom, 4)
        }
        .onAppear {
            isLoading = false
       }
    }
}

#Preview {
    RecipeCardLoadingView()
}
