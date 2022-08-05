
import UIKit

class ExerciseTimerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var topImageView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
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
    var progressView: UIProgressView = {
       let progress = UIProgressView()
        return progress
    }()
    var pauseResumeButton: UIButton = {
        let button = DecaButton.createSocialButton(image: Constants.playImg)
        button.backgroundColor = .white
        button.layer.borderWidth = 0
        button.setTitle("Pause", for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.setImage(UIImage(systemName: "play.fill"), for: .selected)
        button.setTitleColor(DecaColor.decafitPurple.color, for: .normal)
        return button
    }()
    lazy var nextWorkoutButton = DecaButton.createPurpleButton(title: Constants.exerciseTimerButtonText)
    func setupSubviews() {
        [topImageView, exerciseName, progressView, pauseResumeButton, nextWorkoutButton,backButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor),
            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),

            backButton.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: topImageView.topAnchor, constant: 20),
            
            exerciseName.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 10),
            exerciseName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            progressView.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 20),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            pauseResumeButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
            pauseResumeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nextWorkoutButton.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 20),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            nextWorkoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)

        ])
    }
}
