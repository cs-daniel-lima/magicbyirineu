import Realm
import RealmSwift

class CardTypeDao: Object {
    @objc dynamic var name: String = ""
}

extension CardTypeDao {
    convenience init(type: String) {
        self.init()
        name = type
    }
}
