import Realm
import RealmSwift

extension List where Iterator.Element == ForeignNamesDao {
    func append(foreignNames: [ForeignNames]) {
        for foreignName in foreignNames {
            let realmForeingName = ForeignNamesDao(foreingName: foreignName)

            append(realmForeingName)
        }
    }

    func toArray() -> [ForeignNames] {
        var foreingnNames = [ForeignNames]()

        for element in self {
            foreingnNames.append(ForeignNames(fromRealmObject: element))
        }

        return foreingnNames
    }
}
