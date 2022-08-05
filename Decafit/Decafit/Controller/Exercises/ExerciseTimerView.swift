
import UIKit

class ExerciseTimerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemTeal

        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var topImageView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DecaColor.decafitLightGray.color
        return view
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
        button.setTitle(" Pause", for: .normal)
        button.setImage(UIImage(systemName: Constants.pauseImg), for: .normal)
        button.setImage(UIImage(systemName: Constants.playFillSystemImg), for: .selected)
        button.tintColor = DecaColor.decafitPurple.color
        button.titleLabel?.font = decaFont(size: 20, font: .poppinsMedium)
        button.setTitleColor(DecaColor.decafitPurple.color, for: .normal)
        return button
    }()
    lazy var nextWorkoutButton = DecaButton.createPurpleButton(title: Constants.exerciseTimerButtonText)
    func setupSubviews() {
        [topImageView, exerciseName, progressBar,
         stepsTakenView, pauseResumeButton,
         nextWorkoutButton, backButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor),
            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),

            backButton.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: topImageView.topAnchor, constant: 50),
            // title
            exerciseName.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 0),
            exerciseName.leadingAnchor.constraint(equalTo: leadingAnchor),
            exerciseName.trailingAnchor.constraint(equalTo: trailingAnchor),
            exerciseName.centerXAnchor.constraint(equalTo: centerXAnchor),
            // progress bar
            progressBar.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 40),
            progressBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBar.bottomAnchor.constraint(equalTo: pauseResumeButton.topAnchor, constant: -10),
            // hidden view
            stepsTakenView.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 20),
            stepsTakenView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepsTakenView.bottomAnchor.constraint(equalTo: pauseResumeButton.topAnchor, constant: -10),
            stepsTakenView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stepsTakenView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            // pause btn
            pauseResumeButton.topAnchor.constraint(equalTo: stepsTakenView.bottomAnchor, constant: 20),
            pauseResumeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseResumeButton.bottomAnchor.constraint(equalTo: nextWorkoutButton.topAnchor, constant: -25),

            nextWorkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            nextWorkoutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            nextWorkoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)

        ])
    }
}
