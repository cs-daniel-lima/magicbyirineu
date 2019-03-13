import Realm
import RealmSwift

class CardDao: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var set: String = ""
    @objc dynamic var setName: String = ""
    @objc dynamic var imageUrl: String?
    let types = List<RealmString>()
    let foreignNames = List<ForeignNamesDao>()

    @objc dynamic var uniqueIdentifierId = UUID().uuidString

    override static func primaryKey() -> String? {
        return "uniqueIdentifierId"
    }
}

extension CardDao {
    convenience init(card: Card) {
        self.init()
        name = card.name
        set = card.set
        setName = card.setName
        imageUrl = card.imageUrl
        types.append(strings: card.types)
        uniqueIdentifierId = card.id

        if let cardForeignNames = card.foreignNames {
            foreignNames.append(foreignNames: cardForeignNames)
        }
    }
}
