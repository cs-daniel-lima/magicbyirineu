import Realm
import RealmSwift

class CardSetDao: Object {
    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var releaseDate: Date = Date()
}

extension CardSetDao {
    convenience init(set: CardSet) {
        self.init()
        code = set.code
        name = set.name
        type = set.type
        releaseDate = set.releaseDate
    }
}
