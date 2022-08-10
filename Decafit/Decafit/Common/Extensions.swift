
import UIKit
extension TimeInterval {
    var time: String {
        return String(format: "%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
extension UILabel {
    func set(text: String, withKerning kerning: CGFloat) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            NSAttributedString.Key.kern, value: kerning,
            range: NSRange(location: 0, length: text.count))
        attributedText = attributedString
    }

}
extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
extension UIView {
    func addoverlay(color: UIColor = .black, alpha: CGFloat = 0.5) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        overlay.tag = 5
        overlay.accessibilityIdentifier = "overlay"
        addSubview(overlay)
    }
    func removeOverlay() {
        guard let overlay = self.viewWithTag(5) else { return }
        overlay.frame = .zero
        overlay.removeFromSuperview()
    }
}

func toggleLoginSignup(_ currentVC: UIViewController) {
    var screen: UIViewController
    if currentVC === SignupViewController.self {
        screen = LoginViewController.getViewController()
    } else {
        screen = SignupViewController.getViewController()
    }
    screen.modalPresentationStyle = .fullScreen
    currentVC.present(screen, animated: true)
}
