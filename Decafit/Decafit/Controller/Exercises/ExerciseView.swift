import UIKit
class ExerciseView: UIView {
    var timer: DecaTimer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "ExerciseTimerView"
        translatesAutoresizingMaskIntoConstraints = false
        let defaults = UserDefaults.standard
        
        let timeLeft = TimeInterval(defaults.double(forKey: UserDefaultKeys.time))
        timer = DecaTimer(timeLabel: stepsTakenView.timeData, timeLeft: timeLeft)
        
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    func displaySteps() {
        DispatchQueue.main.async { [self] in
            stepsTakenView.startStepCount()
            timer?.startTimer()
        }
    }
    lazy var topImageView: DecaImageView = {
        let img = DecaImageView(frame: .zero)
        img.configure(with: DecaImageViewModel(
                        image: Constants.playImg, contentMode: .scaleToFill,
                        tintColor: .clear))
        return img
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
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    var stepsTakenView = StepsTakenView()
    var pauseResumeButton: UIButton = {
        let button = DecaButton.createSocialButton(image: Constants.playImg)
        button.backgroundColor = .white
        button.layer.borderWidth = 0
        button.setTitle(Constants.pause, for: .normal)
        button.setImage(UIImage(systemName: Constants.pauseImg), for: .normal)
        button.tintColor = DecaColor.purple.color
        button.titleLabel?.font = decaFont(size: 20, font: .poppinsMedium)
        button.setTitleColor(DecaColor.purple.color, for: .normal)
        return button
    }()
    lazy var nextWorkoutButton = DecaButton.createPurpleButton(
        title: Constants.exerciseTimerButtonText)
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
         nextWorkoutButton, timerViewBackButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 390),
            topImageView.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor),
//            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            topImageView.heightAnchor.constraint(equalToConstant: 300),
            // back
            timerViewBackButton.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 20),
            timerViewBackButton.topAnchor.constraint(equalTo: topImageView.topAnchor, constant: 50),
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
            pauseResumeButton.bottomAnchor.constraint(equalTo: nextWorkoutButton.topAnchor, constant: -20),

            nextWorkoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextWorkoutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            nextWorkoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)

        ])
    }
}
