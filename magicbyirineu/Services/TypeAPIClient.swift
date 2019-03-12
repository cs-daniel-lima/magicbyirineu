import Foundation

class TypeAPIClient {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension TypeAPIClient: TypeRepository {
    func fetchTypes(completion: @escaping (Result<[String]>) -> Void) {
        let endpoint = EndpointTypes()

        apiManager.fetch(endpoint) { result, _ in
            switch result {
            case let .success(response):
                completion(.success(response.types))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
