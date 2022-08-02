//
//  Extensions.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
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
//extension UIFont {
//    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
//        let descriptor = fontDescriptor.withSymbolicTraits(traits)
//        return UIFont(descriptor: descriptor!, size: 0)
//    }
//    func bold() -> UIFont {
//        return withTraits(traits: .traitBold)
//    }
//    func italic() -> UIFont {
//        return withTraits(traits: .traitItalic)
//    }
//}
extension UIView {
func addoverlay(color: UIColor = .black, alpha: CGFloat = 0.5) {
    let overlay = UIView()
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.frame = bounds
    overlay.backgroundColor = color
    overlay.alpha = alpha
    addSubview(overlay)
    }
}
