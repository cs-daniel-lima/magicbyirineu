import Foundation

struct ResponseError: Decodable {
    let statusCode: Int
    let statusMessage: String?

    public init(statusCode: Int = 0, statusMessage: String? = nil) {
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }
}
