import Realm
import RealmSwift

extension Results where Iterator.Element == CardDao {
    func toArray() -> [Card] {
        var cards = [Card]()

        for carDao in self {
            cards.append(Card(fromRealmObject: carDao))
        }

        return cards
    }
}
