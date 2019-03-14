import Foundation

final class EndpointSets: Endpoint {
    typealias Response = ResponseSets

    var endpoint: String {
        return "sets"
    }

    let name: String?

    init(name: String? = nil) {
        self.name = name
    }
}
