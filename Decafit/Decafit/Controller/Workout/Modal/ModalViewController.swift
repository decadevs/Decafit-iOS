import UIKit

class ModalViewController: UIViewController {
    var dismissCompletion: (() -> Void)?
    var titleText, imageName, desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(modalView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        modalView.modalTitle.text = titleText
        modalView.topSwipeView.cellImage = imageName
        modalView.modalDetailText.text = desc
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        modalView.topSwipeView.cellImage = " "
        modalView.topSwipeView.cellImage = nil 
    }
    lazy var modalView: ModalView = {
        let popup = ModalView(frame: CGRect(x: 30, y: 30, width: 300, height: view.frame.height*0.6))
        popup.layer.shadowOffset = CGSize(width: 5, height: 12)
        popup.layer.shadowOpacity = 0.2
        popup.center = view.center
        popup.backgroundColor = .white
        popup.layer.cornerRadius = 15
        popup.modalButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return popup
    }()
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
        dismissCompletion?()
    }
}
