import Foundation

class CardAPIClient {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension CardAPIClient: CardRepository {
    func fetchCards(page: Int? = nil, name: String? = nil, setCode: String? = nil, type: String? = nil, orderParameter: CardOrder? = nil, completion: @escaping (Result<[Card]>, HTTPHeaderCards?) -> Void) {
        let endpoint = EndpointCards(page: page, name: name, setCode: setCode, type: type, orderParameter: orderParameter)

        apiManager.fetch(endpoint) { result, httpHeader in
            switch result {
            case let .success(response):

                var httpHeaderCards: HTTPHeaderCards?

                let countHeaderName = "count"
                let totalCountHeaderName = "total-count"

                if let totalCountHeaderValue = httpHeader?[totalCountHeaderName] as? String,
                    let countHeaderValue = httpHeader?[countHeaderName] as? String {
                    guard let totalCount = Int(totalCountHeaderValue) else {
                        completion(.success(response.cards), nil)
                        return
                    }
                    guard let count = Int(countHeaderValue) else {
                        completion(.success(response.cards), nil)
                        return
                    }

                    httpHeaderCards = HTTPHeaderCards(count: count, totalCount: totalCount)
                } else {
                    httpHeaderCards = HTTPHeaderCards(count: 0, totalCount: 0)
                }

                completion(.success(response.cards), httpHeaderCards)
            case let .failure(error):
                completion(.failure(error), nil)
            }
        }
    }
}
