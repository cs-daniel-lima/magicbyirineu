import UIKit

class APIManager {
    // MARK: - Properties

    // MARK: Private

    private let session = URLSession(configuration: .default)

    // MARK: - Init

    // MARK: - Functions

    // MARK: Private

    private func setStatusBar(loading: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
    }

    private func endpoint<EndpointType: Endpoint>(for request: EndpointType) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }

        var endpoint = "https://api.magicthegathering.io/v1/\(request.endpoint)"

        if !parameters.isEmpty {
            endpoint.append("?\(parameters)")
        }

        let url = URL(string: endpoint)!
        return url
    }

    func fetch<EndpointType>(_ request: EndpointType, completion: @escaping (Result<EndpointType.Response>, Int?) -> Void) where EndpointType: Endpoint {
        setStatusBar(loading: true)
        let endpoint = self.endpoint(for: request)
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let magicResponse = try decoder.decode(EndpointType.Response.self, from: data)

                    self.setStatusBar(loading: false)
                    completion(Result.success(magicResponse), self.extractTotalCount(fromResponse: response))

                } catch {
                    self.setStatusBar(loading: false)

                    let decoder = JSONDecoder()
                    if let responseError = try? decoder.decode(ResponseError.self, from: data) {
                        if let htmlResponse = response as? HTTPURLResponse {
                            let httpError = NSError(domain: endpoint.absoluteString,
                                                    code: htmlResponse.statusCode,
                                                    userInfo: ["description": responseError.statusMessage ?? ""])
                            completion(.failure(httpError), nil)
                        }
                    } else {
                        completion(.failure(error), nil)
                    }
                }
            } else if let error = error {
                self.setStatusBar(loading: false)
                completion(.failure(error), nil)
            }
        }
        task.resume()
    }

    func extractTotalCount(fromResponse response: URLResponse?) -> Int? {
        if let httpResponse = response as? HTTPURLResponse {
            if let value = httpResponse.allHeaderFields["Total-Count".lowercased()] {
                if let intValue: Int32 = (value as? NSString)?.intValue {
                    return Int(intValue)
                }
            }
        }

        return nil
    }
}
