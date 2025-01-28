import SwiftUI

extension String {
    func youtubeVideoId() -> String? {
        guard let url = URL(string: self), let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems else {
            return nil
        }
        return queryItems.first(where: { $0.name == "v"})?.value
    }
}
