import UIKit

class MagicSearchBar: UISearchBar {
    let font: UIFont

    init(frame: CGRect, font: UIFont) {
        self.font = font
        super.init(frame: frame)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toSuperview _: UIView?) {
        setupSearchBar()
        setupBarButtonItem()
        setupTextFieldBorders()
        setupTextFieldPlaceholder()
    }

    func setupSearchBar() {
        showsCancelButton = true
        tintColor = .white
        barTintColor = .white
        backgroundColor = .clear
        searchBarStyle = .minimal
    }

    func setupBarButtonItem() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "cancel"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font,
        ], for: UIControl.State.normal)
    }

    func setupTextFieldBorders() {
        guard let textField = value(forKey: "_searchField") as? UITextField else {
            return
        }

        textField.borderStyle = .none
        textField.backgroundColor = UIColor.clear
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
    }

    func setupTextFieldPlaceholder() {
        guard let textField = value(forKey: "_searchField") as? UITextField else {
            return
        }

        textField.textColor = UIColor.white
        textField.attributedPlaceholder =
            NSAttributedString(string: "search for cards", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.font = font
    }

    func additionalSetupAfterDisplay() {
        guard let textField = value(forKey: "_searchField") as? UITextField else {
            return
        }

        // Left padding
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftView = leftPadding

        // Magnifier icon
        let icon = UIImageView(image: UIImage(named: "buscar"))
        textField.rightView = icon
        textField.rightViewMode = .always
    }

    func cancelUserInteraction() {
        guard let textField = value(forKey: "_searchField") as? UITextField else {
            return
        }

        textField.text = ""
        resignFirstResponder()
    }
}
