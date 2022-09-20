import UIKit
class ExerciseView: UIView {
    var timer: DecaTimer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "ExerciseTimerView"
        translatesAutoresizingMaskIntoConstraints = false
        let defaults = UserDefaults.standard

        let timeLeft = TimeInterval( defaults.double(forKey: UserDefaultKeys.time))
        timer = DecaTimer(timeLabel: stepsTakenView.timeData, timeLeft: timeLeft)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    var nextExerciseBtnTitle: String {
        var title = ""
        print("Double().repsTracker", Double().repsTracker)
        print("Int repstracker", Int().repsTracker)
        if Double().repsTracker > 1 {
            title = Constants.repeatExercise
        } else {
            title = Constants.nextExercise
        }
        return title
    }
    
    func displaySteps() {
        DispatchQueue.main.async { [weak self] in
            self?.stepsTakenView.startStepCount()
            self?.stepsTakenView.timeData.text = self?.inputTimeAsInterval
        }
    }
    lazy var topImageView: DecaImageView = {
        let img = DecaImageView(frame: .zero)
        img.configure(with: DecaImageViewModel(
                        image: Constants.playImg, contentMode: .scaleToFill,
                        tintColor: .clear))
        return img
    }()

    lazy var repsProgressTag: DecaButton = {
        let button = DecaButton()
        button.configure(with: DecaButtonViewModel(title: "1 Of 4 Reps", font: decaFont(size: 12, font: .ubuntuMedium), backgroundColor: UIColor.white, titleColor: DecaColor.black.color, image: nil, borderWidth: 1, cornerRadius: 5, borderColor: nil, contentEdgeInsets: UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10), isEnabled: false, tarmic: false))
        button.layer.shadowOffset = CGSize(width: 3, height: 8)
        button.layer.shadowOpacity = 0.2
        return button
    }()
    var exerciseName: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 24, font: .poppinsBold),
                            textColor: DecaColor.black.color,
                            numberOfLines: 1, text: Constants.exerciseLabelText,
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    var timerLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 22, font: .poppinsBold),
                            textColor: DecaColor.black.color,
                            numberOfLines: 1, text: "00:02",
                            kerning: 0.5))
        label.textAlignment = .center
        return label
    }()
    var progressCircle: ProgressCircle = {
       let progress = ProgressCircle()
        progress.pauseAnimation()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    var stepsTakenView = StepsTakenView()
    var pauseResumeButton: DecaButton = {
       let btn = DecaButton()
        btn.configure(with: DecaButtonViewModel(
                        title: Constants.start, font: decaFont(size: 20, font: .poppinsMedium), backgroundColor: .white, titleColor: DecaColor.purple.color, image: UIImage(named: Constants.playImg), borderWidth: 0, cornerRadius: nil, borderColor: nil, contentEdgeInsets: nil, isEnabled: true, tarmic: false))
        btn.tintColor = DecaColor.purple.color
        return btn
    }()
    lazy var nextExerciseButton = DecaButton.createPurpleButton(
        title: Constants.nextExercise)
    let timerViewBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.backArrow), for: .normal)
        button.backgroundColor = DecaColor.lightGray.color
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(
            top: 12, left: 12, bottom: 12, right: 12)
        return button
    }()
    func setupSubviews() {
        [topImageView, exerciseName, progressCircle, timerLabel,
         stepsTakenView, pauseResumeButton,
         nextExerciseButton, timerViewBackButton, repsProgressTag].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 390),
            topImageView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor),
//            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            topImageView.heightAnchor.constraint(equalToConstant: 300),
            // back
            timerViewBackButton.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 20),
            timerViewBackButton.topAnchor.constraint(equalTo: topImageView.topAnchor, constant: 50),
            // reps progress tag
            repsProgressTag.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -5),
            repsProgressTag.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -10),
            // title
            exerciseName.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 30),
            exerciseName.leadingAnchor.constraint(equalTo: leadingAnchor),
            exerciseName.trailingAnchor.constraint(equalTo: trailingAnchor),
            exerciseName.centerXAnchor.constraint(equalTo: centerXAnchor),
            // progress bar
            progressCircle.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 100),
            progressCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressCircle.bottomAnchor.constraint(equalTo: pauseResumeButton.topAnchor, constant: -10),
            // ticker
            timerLabel.centerXAnchor.constraint(equalTo: progressCircle.centerXAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: progressCircle.bottomAnchor, constant: -80),
            // hidden view
            stepsTakenView.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 20),
            stepsTakenView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepsTakenView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stepsTakenView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            // pause btn
            pauseResumeButton.topAnchor.constraint(equalTo: stepsTakenView.bottomAnchor, constant: 40),
            pauseResumeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseResumeButton.bottomAnchor.constraint(equalTo: nextExerciseButton.topAnchor, constant: -20),

            nextExerciseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextExerciseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            nextExerciseButton.centerXAnchor.constraint(equalTo: centerXAnchor)

        ])
    }
}
