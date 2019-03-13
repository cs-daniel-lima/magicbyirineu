import Realm
import RealmSwift

class CardDao: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var set: String = ""
    @objc dynamic var setName: String = ""
    @objc dynamic var imageUrl: String?
    let types = List<RealmString>()
    let foreignNames = List<ForeignNamesDao>()

    required init(card: Card) {
        name = card.name
        set = card.set
        setName = card.setName
        imageUrl = card.imageUrl
        types.append(strings: card.types)

        super.init()
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
