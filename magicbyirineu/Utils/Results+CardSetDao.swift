import Realm
import RealmSwift

extension Results where Iterator.Element == CardSetDao {
    func toArray() -> [CardSet] {
        var sets = [CardSet]()

        for element in self {
            sets.append(CardSet(fromRealmObject: element))
        }

        return sets
    }
}
