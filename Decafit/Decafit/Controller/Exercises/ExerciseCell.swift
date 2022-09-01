import UIKit
protocol ExerciseCellDelegate: AnyObject {
    func gotoNextExercise(pauseTime: TimeInterval)
    func clickNavBackButton()
    func updatePauseTime(pauseTime: TimeInterval, resumeTapped: Bool)
    func startExercise()
}
class ExerciseCell: UICollectionViewCell {
    static let identifier = Constants.exerciseCellId
    weak var exerciseCellDelegate: ExerciseCellDelegate?
    let defaults = UserDefaults.standard
    let dataman = DataManager.shared
    
    var timer: DecaTimer?
    var resumeTapped = false
    var pauseTime: TimeInterval = 0
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(exerciseView)
        contentView.frame = exerciseView.bounds
        addTargets()

        let timeLeft = TimeInterval(defaults.double(forKey: UserDefaultKeys.time))
        
        timer = DecaTimer(timeLabel: exerciseView.timerLabel, timeLeft: timeLeft)
        exerciseView.timerLabel.text = timer?.timeLeft.time
        exerciseView.progressCircle.setProgress(duration: timer?.timeLeft ?? 20 )
        timer?.startTimer()
    
        exerciseCellDelegate?.startExercise()

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
    func configure(with model: WorkoutListQuery.Data.Workout.Exercise) {
        exerciseView.exerciseName.text = model.title
        exerciseView.topImageView.kf.setImage(with: URL(string: model.image), placeholder: UIImage(named: "back"), options: nil, completionHandler: nil)
    }
    @objc func clickNavBackButton() {
        exerciseCellDelegate?.clickNavBackButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
extension ExerciseCell {
    @objc func gotoNextExercise(_ sender: UIButton) {
        exerciseCellDelegate?.gotoNextExercise(pauseTime: pauseTime)
    }
    @objc func pauseButtonTapped(_ sender: UIButton) {
        if sender.tag == Tags.stepcell {
            let timer = exerciseView.timer
            pauseTimer(timer: timer!)
        } else {
            pauseTimer(timer: self.timer!)
        }
    }
    func pauseTimer(timer: DecaTimer) {
        if resumeTapped == false {
            timer.invalidate()
            timer.isTimerRunning = false
            resumeTapped = true
            pauseTime = timer.timeLeft
            exerciseCellDelegate?.updatePauseTime(pauseTime: pauseTime, resumeTapped: resumeTapped)
            exerciseView.progressCircle.pauseAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.resume, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.playFillSystemImg), for: .normal)
        } else {
            timer.runTimer()
            resumeTapped = false
            timer.isTimerRunning = true
            exerciseView.progressCircle.resumeAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.pause, for: .normal)
            exerciseView.pauseResumeButton.setImage(
               UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
