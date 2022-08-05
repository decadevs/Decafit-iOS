
import UIKit

class ExerciseTimerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    // topview, label, round progress view, button, purple button
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
    var pauseResumeButton: UIButton = {
        let button = DecaButton.createSocialButton(image: Constants.playImg)
        button.backgroundColor = .white
        button.layer.borderWidth = 0
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: ""), for: .normal)
        button.setImage(UIImage(systemName: ""), for: .selected)
        button.setTitleColor(DecaColor.decafitPurple.color, for: .normal)
        return button
    }()
    lazy var nextWorkoutButton = DecaButton.createPurpleButton(title: Constants.exerciseTimerButtonText)
    func setupSubviews() {
        [topImageView, exerciseName, pauseResumeButton, nextWorkoutButton,backButton].forEach { addSubview($0)}
    }
}
