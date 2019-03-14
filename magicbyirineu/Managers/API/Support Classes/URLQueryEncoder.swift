import Foundation

enum URLQueryEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        let parametersString = parameters.map({ (value) -> String in
            "\(value.key)=\(value.value)"
        })
        let parametersSequence = parametersString.joined(separator: "&")
        let parametersEncoded = parametersSequence.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return parametersEncoded
    }
}
