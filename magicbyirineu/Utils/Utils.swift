import Realm
import RealmSwift

class Utils {
    class func createConfigurationFile() -> Realm.Configuration {
        return Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                Logger.log(in: self, message: "Migrating database from version \(oldSchemaVersion)")
            },
            shouldCompactOnLaunch: { totalBytes, usedBytes in
                (Double(usedBytes) / Double(totalBytes)) < 0.5
            }
        )
    }
}
