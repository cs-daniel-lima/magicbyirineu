import UIKit

class ErrorMock: Error {
    var localizedDescription: String {
        return "Test got an error"
    }
}
