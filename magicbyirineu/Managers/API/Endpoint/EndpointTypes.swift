import Foundation

final class EndpointTypes: Endpoint {
    typealias Response = ResponseTypes

    var endpoint: String {
        return "types"
    }
}
