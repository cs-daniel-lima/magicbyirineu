import Foundation

struct CardSet: Decodable {
    let code: String
    let name: String
    let type: String
    let releaseDate: Date
}

extension CardSet: Hashable {}
