import Realm
import RealmSwift

extension List where Iterator.Element == ForeignNamesDao {
    func toArray() -> [ForeignNames] {
        var foreingnNames = [ForeignNames]()

        for element in self {
            foreingnNames.append(ForeignNames(fromRealmObject: element))
        }

        return foreingnNames
    }
}
