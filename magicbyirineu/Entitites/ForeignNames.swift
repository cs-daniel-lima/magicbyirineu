import Foundation

struct ForeignNames: Decodable {
    let name: String
    let imageUrl: String?
}

extension ForeignNames {
    init(fromRealmObject object: ForeignNamesDao) {
        name = object.name
        imageUrl = object.imageUrl
    }
}
