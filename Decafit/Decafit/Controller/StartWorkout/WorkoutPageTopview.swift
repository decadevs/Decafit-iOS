
import UIKit
class WorkoutPageTopview: UIView {
    lazy var titleLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 24, font: .poppinsBold),
                            textColor: .white, numberOfLines: 1,
                            text: "10 Workouts", kerning: 1.0))
        return label
    }()
    lazy var timeLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Third", kerning: 0.5))
        label.attributedText = label.setAttributedText(image: "clock", textAfterIcon: " 24 min")
        return label
    }()
    lazy var calorieLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Fourth", kerning: 0.5))
        label.attributedText = label.setAttributedText(image: "flame.fill", textAfterIcon: " 240 Kcal")
        return label
    }()
    lazy var topImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: Constants.weightImg))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.addoverlay(color: DecaColor.decafitPurple.color)
        return image
    }()
    let workoutTopviewBackButton: DecaButton = {
        let btn = DecaButton.createSocialButton(image: Constants.backArrow)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 0
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 12, left: 12, bottom: 12, right: 12)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .green
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    func initialize() {
        [topImage, workoutTopviewBackButton, titleLabel, timeLabel, calorieLabel].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            topImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            topImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            workoutTopviewBackButton.topAnchor.constraint(equalTo: topImage.topAnchor, constant: 55),
            workoutTopviewBackButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),

            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            calorieLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 0),
            calorieLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10)
        ])
    }
}
