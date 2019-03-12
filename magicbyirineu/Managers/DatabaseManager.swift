import Realm
import RealmSwift

class DatabaseManager {
    let realm: Realm
    
    init() {
        let config = Utils.createConfigurationFile()
        realm = try! Realm(configuration: config)
    }
}
