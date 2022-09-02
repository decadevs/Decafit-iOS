import UIKit
class Alert {
    static func showAlert(_ presenter: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    static func showDialog(_ presenter: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Resume", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Restart", style: .destructive, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
        
    }

}
