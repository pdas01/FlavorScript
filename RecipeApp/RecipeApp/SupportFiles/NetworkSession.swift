import SwiftUI

// Any type conforming to NetworkSession must be safe to use across concurrency domains
protocol NetworkSession: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
