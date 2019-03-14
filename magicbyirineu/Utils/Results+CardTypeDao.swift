import Realm
import RealmSwift

extension Results where Iterator.Element == CardTypeDao {
    func toArrayOfString() -> [String] {
        var types = [String]()

        for element in self {
            types.append(element.name)
        }

        return types
    }
}
