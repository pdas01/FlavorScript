import Foundation

extension Data {
    func decode<ResponseObject: Codable>() throws -> ResponseObject {
        if self.isEmpty, let response = EmptyResponse() as? ResponseObject {
            return response
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(ResponseObject.self, from: self)
    }
}

struct EmptyResponse: Codable {}

