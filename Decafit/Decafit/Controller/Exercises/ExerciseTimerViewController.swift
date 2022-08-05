
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        exerciseTimerView.progressBar.handleTap()
    }
    @objc func pauseResumeButtonTapped(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: Constants.pauseImg) {
            // exerciseTimerView.progressBar.progress = 0.5 // pause progress
            if exerciseLabel.text == Constants.run {
                // replace progress view with 2 labels - Steps taken and time remaining
            }
            sender.setImage(UIImage(systemName: Constants.playFillSystemImg), for: .normal)
        } else {
            // exerciseTimerView.progressBar.progress = 0.3 // resume progress
            sender.setImage(UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
