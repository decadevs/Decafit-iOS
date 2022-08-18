import UIKit
protocol ExerciseCellDelegate: AnyObject {
    func gotoNextExercise()
    func clickNavBackButton()
}
class ExerciseCell: UICollectionViewCell {
    static let identifier = Constants.exerciseCellId
    weak var delegate: ExerciseCellDelegate?
    var timer: DecaTimer?
    var resumeTapped = false
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(exerciseView)
        contentView.frame = exerciseView.bounds
        
        exerciseView.timerViewBackButton.addTarget(
            self, action: #selector(clickNavBackButton),
            for: .touchUpInside)
        exerciseView.nextWorkoutButton.addTarget(
            self, action: #selector(gotoNextExercise), for: .touchUpInside)
        exerciseView.pauseResumeButton
            .addTarget(self, action: #selector(pauseButtonTapped),
                       for: .touchUpInside)
        timer = DecaTimer(timeLabel: exerciseView.timerLabel)
        exerciseView.timerLabel.text = timer?.timeLeft.time
        exerciseView.progressBar.setProgress(duration: timer?.timeLeft ?? 30 )
        timer?.startTimer()
        
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
    @objc func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer?.invalidate()
            timer?.isTimerRunning = false
            self.resumeTapped = true
            exerciseView.progressBar.pauseAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.resume, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.playFillSystemImg), for: .normal)
        } else {
            timer?.runTimer()
            self.resumeTapped = false
            timer?.isTimerRunning = true
             exerciseView.progressBar.resumeAnimation()
            exerciseView.pauseResumeButton.setTitle(Constants.pause, for: .normal)
            exerciseView.pauseResumeButton.setImage(
                UIImage(systemName: Constants.pauseImg), for: .normal)
        }
    }
}
