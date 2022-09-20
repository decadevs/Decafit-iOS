//
//  Extensions.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit
import KeychainSwift
var defaults = UserDefaults.standard
let realmDb = StorageManager.shared

extension TimeInterval {
    var time: String {
        return String(format: "%02d:%02d", Int(self/60),
                      Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
    var repsTracker: Int {
        return defaults.integer(forKey: UserDefaultKeys.repsTracker)
    }
    var setsTracker: Int {
        return defaults.integer(forKey: UserDefaultKeys.setsTracker)
    }

}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    var repsTracker: Double {
        return defaults.double(forKey: UserDefaultKeys.repsTracker)
    }
    var setsTracker: Double {
        return defaults.double(forKey: UserDefaultKeys.setsTracker)
    }
}
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) {
        if value {
            self.setValue(true, forKey: Constants.removeShadow)
        } else {
            self.setValue(false, forKey: Constants.removeShadow)
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
        overlay.tag = Tags.overlay
        overlay.accessibilityIdentifier = Constants.overlayIdentifier
        addSubview(overlay)
    }
    func removeOverlay() {
        guard let overlay = self.viewWithTag(Tags.overlay) else { return }
        overlay.frame = .zero
        overlay.removeFromSuperview()
    }
    func getUserID() -> String {
        guard let key = KeychainSwift().get(Constants.userID) else {
            fatalError("User not logged in yet")
        }
        return key
    }
    var inputTimeAsInterval: String {
        let timeLeft = TimeInterval(defaults.double(forKey: UserDefaultKeys.time))
        let endTime = Date().addingTimeInterval(timeLeft)
        let time = endTime.timeIntervalSinceNow.time
        
        return time
    }
}
extension UIViewController {
    func toggleAuthScreens(_ sender: UIButton) {
        let screen: UIViewController
        if sender.tag == Tags.orangeSignInLink {
            screen = LoginViewController.getViewController()
        } else {
            screen = SignupViewController.getViewController()
        }
        screen.modalTransitionStyle = .flipHorizontal
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
    var homeVC: UIViewController {
        let home = UINavigationController(rootViewController: HomeViewController())
        return home
    }
    
}
extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    func moveToFrame(contentOffset: CGFloat) {
            self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
extension FileManager {
    func getDocumentDirectory() -> URL {
        return self.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    func getCache() -> URL { 
        return self.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("apollo_cache.sqlite")
    }
}
