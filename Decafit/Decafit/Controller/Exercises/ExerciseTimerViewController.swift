import UIKit

class ExerciseTimerViewController: UIViewController {
    var timeLeft: TimeInterval = 10 // parse this from the exercise cell duration
    var endTime: Date?
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(exerciseTimerView)
        exerciseTimerView.frame = view.bounds
        exerciseTimerView.timerLabel.text = timeLeft.time
        exerciseTimerView.pauseResumeButton
            .addTarget(self, action: #selector(pauseButtonTapped),
                       for: .touchUpInside)
        exerciseTimerView.progressBar.setProgress(duration: timeLeft )
    }
    lazy var exerciseTimerView = ExerciseTimerView()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startWorkoutButtonTapped()
    }
    func startWorkoutButtonTapped() {
        if isTimerRunning == false {
            runTimer()
        }
    }
    func runTimer() {
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: (#selector(updateTimer)),
                                     userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTimer() {
        let timeLabel = exerciseTimerView.timerLabel
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00:00"
            timer.invalidate()
            // Play sound to indicate time up
        }
    }
    @objc func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            exerciseTimerView.progressBar.pauseAnimation()
            if exerciseTimerView.exerciseName.text == Constants.run {
                // replace progress view with steps taken view
            }
            exerciseTimerView.pauseResumeButton.setTitle(Constants.resume, for: .normal)
            exerciseTimerView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.playFillSystemImg), for: .selected)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
             exerciseTimerView.progressBar.resumeAnimation()
            exerciseTimerView.pauseResumeButton.setTitle(Constants.pause, for: .normal)
            exerciseTimerView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
