import Foundation

final class EndpointCards: Endpoint {
    typealias Response = ResponseCards

    var endpoint: String {
        return "cards"
    }

    let page: Int?
    let name: String?
    let set: String?
    let type: String?
    let orderBy: String?

    init(page: Int? = nil, name: String? = nil, setCode: String? = nil, type: String? = nil, orderParameter: CardOrder? = nil) {
        self.page = page
        self.name = name
        set = setCode
        self.type = type
        orderBy = orderParameter?.rawValue
    }
}
