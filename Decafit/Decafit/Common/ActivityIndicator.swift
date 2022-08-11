import UIKit
class ActivityIndicator: UIActivityIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        stopAnimating()
        removeFromSuperview()
        style = .large
        tag = 200
    }
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: .large)
    }
    
    required init(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    static func addActivityIndicator(presenter: UIViewController) {
//        let indicator = presenter.view.viewWithTag(200)!
//        if presenter.view.subviews.contains(indicator) {
//            print("-----------> ==========>", indicator)
//            indicator.isHidden = false
//        }
//        else {
            let act = Self()
            act.center = presenter.view.center
            act.hidesWhenStopped = false
            act.startAnimating()
            presenter.view.addSubview(act)
//        }
    }
    static func removeActivityIndicator() {
        let act = Self()
        act.stopAnimating()
        act.removeFromSuperview()
//        DispatchQueue.main.async {
//            act.stopAnimating()
//            act.removeFromSuperview()
//        }
    }
}
