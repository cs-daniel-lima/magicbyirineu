import Realm
import RealmSwift

extension List where Iterator.Element == RealmString {
    func append(strings: [String]) {
        for string in strings {
            let realmString = RealmString()
            realmString.stringValue = string
            append(realmString)
        }
    }

    func toStrings() -> [String] {
        var strings = [String]()

        for element in self {
            strings.append(element.stringValue)
        }

        return strings
    }
}
