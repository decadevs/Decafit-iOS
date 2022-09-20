import UIKit
class Alert {
    static var firstActionComplete: (() -> Void)?
    static var secondActionComplete: (() -> Void)?

    static func showAlert(_ presenter: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    static func showDialog(_ presenter: UIViewController, title: String, message: String, firstAction: String, secondAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstAction, style: .destructive, handler: { _ in
            firstActionComplete?()
        }))
        alert.addAction(UIAlertAction(title: secondAction, style: .default, handler: { _ in
            print("Second action selected")
            secondActionComplete?()
        }))
        presenter.present(alert, animated: true, completion: nil)
        
    }

}
