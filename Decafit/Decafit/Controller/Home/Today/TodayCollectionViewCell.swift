
import UIKit
class TodayCollectionViewCell: UICollectionViewCell {
    static let identifier = Constants.todayCellId
    var todayCell: TodaySessionModel? {
        didSet {
            guard todayCell != nil else {
                return
            }
            todayImage.image = UIImage(named: todayCell?.image ?? Constants.weightImg)
            firstLabel.text = todayCell?.title ?? Constants.goodMorning
            secondLabel.text = todayCell?.name ?? Constants.goodMorning
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    let todayImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addoverlay(color: DecaColor.decafitPurple.color)
        return image
    }()
    let firstLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 24, font: .poppinsMedium).bold(),
                            textColor: .white, numberOfLines: 1,
                            text: Constants.todayFirstLabelText, kerning: 1.0))
        return label
    }()
    let secondLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 12, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: Constants.todaySecondLabelText, kerning: 0.5))
        return label
    }()
    let thirdLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "", kerning: 0.5))
        label.attributedText = label.setAttributedText(
            image: Constants.clockImg,
            textAfterIcon: Constants.todayThirdLabelTextAfterIcon)
        return label
    }()
    let fourthLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "", kerning: 0.5))
        label.attributedText = label.setAttributedText(
            image: Constants.flameImg,
            textAfterIcon: Constants.todayFourthLabelTextAfterIcon)
        return label
    }()
    var playButton: UIButton = {
        let button = DecaButton.createSocialButton(image: Constants.playImg)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        return button
    }()
    func setupViews() {
        [todayImage, firstLabel, secondLabel, playButton,
         thirdLabel, fourthLabel].forEach { contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            todayImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            todayImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5),
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor, constant: 0),
            playButton.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: -10),
            playButton.trailingAnchor.constraint(equalTo: todayImage.trailingAnchor, constant: -25),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 40),
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 5),
            thirdLabel.leadingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: 0),
            fourthLabel.topAnchor.constraint(equalTo: thirdLabel.topAnchor, constant: 0),
            fourthLabel.leadingAnchor.constraint(equalTo: thirdLabel.trailingAnchor, constant: 10)
        ])
    }
}
