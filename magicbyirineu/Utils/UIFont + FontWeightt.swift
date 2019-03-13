import UIKit

extension UIFont {
    enum FontWeight: String {
        case bold = "Bold"
        case regular = "Regular"
    }

    class func sfProDisplay(size: CGFloat, weight: FontWeight) -> UIFont {
        let fontName = "SFProDisplay-" + weight.rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont()
        }
        return font
    }
}
