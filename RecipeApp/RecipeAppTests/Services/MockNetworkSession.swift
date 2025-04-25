import SwiftUI
@testable import RecipeApp

final class MockNetworkSession: NetworkSession, @unchecked Sendable {
    var mockData: Data?
    var shouldThrowError = false

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }

        let data = mockData ?? Data()
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        return (data, response)
    }
}

