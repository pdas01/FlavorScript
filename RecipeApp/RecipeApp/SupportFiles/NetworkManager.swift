import SwiftUI

/**
 NetworkManager deals with fetching network calls and decoding to desired format 
 */
@MainActor
final class NetworkManager {
    func recipes(_ fileURLWithPath: String) async throws -> RecipeList? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: fileURLWithPath))
            return try data.decode()
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error.localizedDescription)
        }  catch {
            throw NetworkError.error(error.localizedDescription)
        }
    }
}

enum NetworkError: Error {
    case decodingError(String)
    case error(String)
}
