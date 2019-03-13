import Realm
import RealmSwift

class ForeignNamesDao: Object {
    @objc dynamic var name = ""
    @objc dynamic var imageUrl: String?
}

extension ForeignNamesDao {
    convenience init(foreingName: ForeignNames) {
        self.init()
        name = foreingName.name
        imageUrl = foreingName.imageUrl
    }
}
