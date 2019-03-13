import Foundation

struct CardSet: Decodable, Hashable {
    let code: String
    let name: String
    let type: String
    let releaseDate: Date
}

extension CardSet {
    init(fromRealmObject object: CardSetDao) {
        code = object.code
        name = object.name
        type = object.type
        releaseDate = object.releaseDate
    }
}
