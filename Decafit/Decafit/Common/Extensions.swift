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

open class CustomLabel: UILabel {
    @IBInspectable open var characterSpacing: CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(
                NSAttributedString.Key.kern, value: self.characterSpacing,
                range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

    }
}
