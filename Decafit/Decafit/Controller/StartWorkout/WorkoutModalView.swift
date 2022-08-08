
import UIKit

class WorkoutModalView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var workoutModalImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = DecaColor.decafitLightGray.color
        return image
    }()
    lazy var workoutModalTitle: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 20, font: .poppinsMedium),
                            textColor: .black, numberOfLines: 1,
                            text: Constants.exerciseLabelText, kerning: 1.0))
        return label
    }()

    lazy var scrollview: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(workoutModalDetailText)
        return scroll
    }()
    lazy var workoutModalDetailText: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsRegular),
                            textColor: DecaColor.decafitDarkGray.color, numberOfLines: 0,
                            text: Constants.loremText, kerning: nil))
        label.sizeToFit()
        return label
    }()
    var workoutModalButton: DecaButton = {
        let btn = DecaButton()
        btn.configure(with: DecaButtonViewModel(
                        title: Constants.close,
                        font: decaFont(size: 14, font: .poppinsRegular),
                        backgroundColor: .clear,
                        titleColor: DecaColor.decafitPurple.color,
                        image: nil, borderWidth: 1, cornerRadius: 4,
                        borderColor: DecaColor.decafitPurple.color.cgColor,
                        contentEdgeInsets: nil, isEnabled: true, tarmic: false))
        return btn
    }()
    func setupSubviews() {
        [workoutModalImage, workoutModalTitle, scrollview, workoutModalButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            workoutModalImage.topAnchor.constraint(equalTo: topAnchor),
            workoutModalImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            workoutModalImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            workoutModalImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            workoutModalImage.widthAnchor.constraint(equalTo: widthAnchor),
            
            workoutModalTitle.topAnchor.constraint(equalTo: workoutModalImage.bottomAnchor, constant: 0),
            workoutModalTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutModalTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            scrollview.topAnchor.constraint(equalTo: workoutModalTitle.bottomAnchor),
            scrollview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            scrollview.widthAnchor.constraint(equalTo: widthAnchor),
            scrollview.bottomAnchor.constraint(equalTo: workoutModalButton.topAnchor, constant: -10),

            workoutModalDetailText.topAnchor.constraint(equalTo: scrollview.topAnchor),
            workoutModalDetailText.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            workoutModalDetailText.widthAnchor.constraint(equalTo: scrollview.widthAnchor, multiplier: 0.85),
            workoutModalDetailText.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: -100),

            workoutModalButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            workoutModalButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            workoutModalButton.heightAnchor.constraint(equalToConstant: 38),
            workoutModalButton.widthAnchor.constraint(equalToConstant: 104)
        ])
    }
}
