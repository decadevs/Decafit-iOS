
import UIKit

class ExerciseTimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(exerciseTimerView)
        exerciseTimerView.frame = view.bounds
        exerciseTimerView.pauseResumeButton.addTarget(self, action: #selector(pauseResumeButtonTapped), for: .touchUpInside)
    }
    lazy var exerciseTimerView = ExerciseTimerView()
    @objc func pauseResumeButtonTapped(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: Constants.pauseImg) {
            exerciseTimerView.progressView.progress = 0.5 // pause progress
            sender.setImage(UIImage(systemName: Constants.playFillSystemImg), for: .normal)
        } else {
            exerciseTimerView.progressView.progress = 0.3 // resume progress
            sender.setImage(UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
