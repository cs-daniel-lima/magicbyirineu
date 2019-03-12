import Foundation

protocol Endpoint: Encodable {
    associatedtype Response: Decodable

    var endpoint: String { get }
}
