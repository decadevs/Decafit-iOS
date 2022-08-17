import UIKit
protocol ExerciseCellDelegate: AnyObject {
    func gotoNextExercise()
    func clickNavBackButton()
}
class ExerciseCell: UICollectionViewCell {
    static let identifier = Constants.exerciseCellId
    weak var delegate: ExerciseCellDelegate?
    var evc = ExerciseViewController()
    var completion: (() -> Void)?
    var timeLeft: TimeInterval = 15 // parse this from the exercise cell duration
    var endTime: Date?
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(exerciseView)
        contentView.frame = exerciseView.bounds
        
        exerciseView.timerViewBackButton.addTarget(
            self, action: #selector(clickNavBackButton), for: .touchUpInside)
        exerciseView.nextWorkoutButton.addTarget(
            self, action: #selector(gotoNextExercise), for: .touchUpInside)
        
        exerciseView.pauseResumeButton
            .addTarget(self, action: #selector(pauseButtonTapped),
                       for: .touchUpInside)
        exerciseView.timerLabel.text = timeLeft.time
        exerciseView.progressBar.setProgress(duration: timeLeft )
        startTimer()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var exerciseView = ExerciseView()
    // MARK: - Delegates
    @objc func gotoNextExercise() {
        delegate?.gotoNextExercise()
    }
    @objc func clickNavBackButton() {
        delegate?.clickNavBackButton()
    }
    func configure(with model: StartWorkoutModel) {
        exerciseView.exerciseName.text = model.exerciseName
        exerciseView.topImageView.image = UIImage(named: model.image)
    }
    func startTimer() {
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
        let timeLabel = exerciseView.timerLabel
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
            exerciseView.progressBar.pauseAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.resume, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.playFillSystemImg), for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
             exerciseView.progressBar.resumeAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.pause, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
