import UIKit
protocol ExerciseCellDelegate: AnyObject {
    func gotoNextExercise()
    func clickNavBackButton()
    func updatePauseTime(pauseTime: TimeInterval)
}
class ExerciseCell: UICollectionViewCell {
    static let identifier = Constants.exerciseCellId
    weak var exerciseCellDelegate: ExerciseCellDelegate?
    let defaults = UserDefaults.standard
    var timer: DecaTimer?
    var resumeTapped = false
    var pauseTime: TimeInterval = 0
    var exerciseStarted: Bool = false
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(exerciseView)
        contentView.frame = exerciseView.bounds
        addTargets()
        timer = DecaTimer(timeLabel: exerciseView.timerLabel)
        exerciseView.timerLabel.text = timer?.timeLeft.time
        exerciseView.progressCircle.setProgress(duration: timer?.timeLeft ?? 30 )
        timer?.startTimer()
        exerciseStarted = true 
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var exerciseView = ExerciseView()
    func addTargets() {
        exerciseView.timerViewBackButton.addTarget(
            self, action: #selector(clickNavBackButton),
            for: .touchUpInside)
        exerciseView.nextWorkoutButton.addTarget(
            self, action: #selector(gotoNextExercise),
            for: .touchUpInside)
        exerciseView.pauseResumeButton.addTarget(
            self, action: #selector(pauseButtonTapped),
            for: .touchUpInside)
    }
    // MARK: - Delegates
    func configure(with model: Exercise) {
        exerciseView.exerciseName.text = model.exerciseName
        exerciseView.topImageView.image = UIImage(named: model.image)
    }
    @objc func gotoNextExercise() {
        // setDuration is coming from time input field in FitConfig
//        if pauseTime < setDuration {
//            isComplete = false
//        } else {
//            isComplete = true
        // save it 
//        }
        exerciseCellDelegate?.gotoNextExercise()
    }
    @objc func clickNavBackButton() {
        exerciseCellDelegate?.clickNavBackButton()
    }
    @objc func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer?.invalidate()
            timer?.isTimerRunning = false
            self.resumeTapped = true
            pauseTime = timer?.timeLeft ?? 0.0
            exerciseCellDelegate?.updatePauseTime(pauseTime: pauseTime)
            exerciseView.progressCircle.pauseAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.resume, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.playFillSystemImg), for: .normal)
        } else {
            timer?.runTimer()
            self.resumeTapped = false
            timer?.isTimerRunning = true
             exerciseView.progressCircle.resumeAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.pause, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
