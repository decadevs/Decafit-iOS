import UIKit

class PopoverViewController: UIViewController {
    var dismissCompletion: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(modalView)
    }
    lazy var modalView: WorkoutModalView = {
        let popup = WorkoutModalView(frame: CGRect(x: 30, y: 30, width: 300, height: view.frame.height*0.6))
        popup.layer.shadowOffset = CGSize(width: 5, height: 12)
        popup.layer.shadowOpacity = 0.2
        popup.center = view.center
        popup.backgroundColor = .white
        popup.layer.cornerRadius = 15
        popup.workoutModalButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return popup
    }()
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
        dismissCompletion?()
    }
}
