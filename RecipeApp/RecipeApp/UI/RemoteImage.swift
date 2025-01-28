import SwiftUI

struct RemoteImage: View {
    let imageString: String
    @StateObject var imageLoadingService = ImageLoadingService()
    var body: some View {
        ImageView(image: imageLoadingService.image)
            .task {
                if let url = URL(string: imageString) {
                    await imageLoadingService.loadImage(url: url)
                }
                
            }
    }
}

struct ImageView: View {
    let image: Image?
    var body: some View {
        image?.resizable() ?? Image(systemName: SystemImageConstants.placeholderPhotoIcon).resizable()
    }
}
