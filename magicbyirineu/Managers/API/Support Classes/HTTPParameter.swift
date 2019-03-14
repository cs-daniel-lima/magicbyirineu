import Foundation

enum HTTPParameter: Decodable {
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else {
            throw APIManager.APIError.decoding
        }
    }
}

extension HTTPParameter: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .string(string):
            return string
        case let .bool(bool):
            return String(describing: bool)
        case let .int(int):
            return String(describing: int)
        case let .double(double):
            return String(describing: double)
        }
    }
}
