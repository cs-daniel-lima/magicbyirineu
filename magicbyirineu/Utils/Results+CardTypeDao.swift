import Realm
import RealmSwift

extension Results where Iterator.Element == CardTypeDao {
    func toArrayOfString() -> [String] {
        var types = [String]()

        for element in self {
            types.append(element.name)
        }
        
        types = types.sorted{$0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending}
        
        return types
    }
}
