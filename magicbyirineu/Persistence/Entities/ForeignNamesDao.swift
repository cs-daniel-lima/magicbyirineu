import Realm
import RealmSwift

class ForeignNamesDao: Object {
    @objc dynamic var name = ""
    @objc dynamic var imageUrl: String?
}
