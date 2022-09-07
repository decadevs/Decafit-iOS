import UIKit
class Alert {
    static func showAlert(_ presenter: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    static func showDialog(_ presenter: UIViewController, title: String, message: String, firstAction: String, secondAction: String, completion: @escaping (Bool) -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstAction, style: .destructive, handler: { _ in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: secondAction, style: .default, handler: { _ in
            completion(false)
        }))
        presenter.present(alert, animated: true, completion: nil)
        
    }

}
