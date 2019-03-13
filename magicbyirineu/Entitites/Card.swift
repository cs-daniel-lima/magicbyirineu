import Foundation

struct Card: Decodable, Equatable {
    let name: String
    let set: String
    let setName: String
    let imageUrl: String?
    let types: [String]
    let foreignNames: [ForeignNames]?

    static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        if lhs.set != rhs.set {
            return false
        }
        if lhs.setName != rhs.setName {
            return false
        }
        if lhs.imageUrl != rhs.imageUrl {
            return false
        }
        if lhs.name != rhs.name {
            return false
        }
        if lhs.foreignNames?.count != rhs.foreignNames?.count {
            return false
        }

        return true
    }
}

extension Card {
    init(fromRealmObject object: CardDao) {
        name = object.name
        set = object.set
        setName = object.setName
        imageUrl = object.imageUrl
        types = object.types.toStrings()
        foreignNames = object.foreignNames.toArray()
    }
}
