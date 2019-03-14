import Foundation

struct ResponseTypes: Decodable {
    let types: [String]

    init(_ types: [String]) {
        self.types = types
    }
}
