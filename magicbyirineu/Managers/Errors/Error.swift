import Foundation

extension APIManager {
    enum APIError: Error {
        case encoding
        case decoding
        case server(message: String)
    }
}
