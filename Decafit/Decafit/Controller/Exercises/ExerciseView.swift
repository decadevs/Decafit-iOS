import UIKit
protocol ExerciseViewDelegate: AnyObject {
    func passViewMembers()
}
class ExerciseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "ExerciseTimerView"
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
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
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: Constants.exerciseLabelText,
                            kerning: 0))
        label.textAlignment = .center
        return label
    }()
    var timerLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 22, font: .poppinsBold),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "00:02",
                            kerning: 0.5))
        label.textAlignment = .center
        return label
    }()
    var progressBar: ProgressBar = {
       let progress = ProgressBar()
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
        button.tintColor = DecaColor.decafitPurple.color
        button.titleLabel?.font = decaFont(size: 20, font: .poppinsMedium)
        button.setTitleColor(DecaColor.decafitPurple.color, for: .normal)
        return button
    }()
    lazy var nextWorkoutButton = DecaButton.createPurpleButton(
        title: Constants.exerciseTimerButtonText)
    let timerViewBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.backArrow), for: .normal)
        button.backgroundColor = DecaColor.decafitLightGray.color
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(
            top: 12, left: 12, bottom: 12, right: 12)
        return button
    }()
    func setupSubviews() {
        [topImageView, exerciseName, progressBar, timerLabel,
         stepsTakenView, pauseResumeButton,
         nextWorkoutButton, timerViewBackButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 390),
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor),
            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            // back
            timerViewBackButton.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 20),
            timerViewBackButton.topAnchor.constraint(equalTo: topImageView.topAnchor, constant: 50),
            // title
            exerciseName.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 40),
            exerciseName.leadingAnchor.constraint(equalTo: leadingAnchor),
            exerciseName.trailingAnchor.constraint(equalTo: trailingAnchor),
            exerciseName.centerXAnchor.constraint(equalTo: centerXAnchor),
            // progress bar
            progressBar.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 100),
            progressBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBar.bottomAnchor.constraint(equalTo: pauseResumeButton.topAnchor, constant: -10),
            // ticker
            timerLabel.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: -70),
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
