//
//  TodayCollectionViewCell.swift
//  Decafit
//
//  Created by Decagon on 28/07/2022.
//
import UIKit
class TodayCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodayCell"
    var todayCell: TodaySessionModel? {
        didSet {
            guard todayCell != nil else {
                return
            }
            todayImage.image = UIImage(named: todayCell?.image ?? "")
            firstLabel.text = todayCell?.title ?? "First Label"
            secondLabel.text = todayCell?.name ?? "Second Label"
        }
    }
    lazy var firstLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 24, font: .poppinsMedium).bold(),
                            textColor: .white, numberOfLines: 1,
                            text: "First", kerning: 1.0))
        label.backgroundColor = .black
        return label
    }()
    lazy var secondLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 12, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Second", kerning: 0.5))
        label.backgroundColor = .black
        return label
    }()
    lazy var thirdLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Third", kerning: 0.5))
        label.attributedText = label.setAttributedText(image: "clock", textAfterIcon: " 24 min")
        label.backgroundColor = .black
        return label
    }()
    lazy var fourthLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Fourth", kerning: 0.5))
        label.attributedText = label.setAttributedText(image: "flame.fill", textAfterIcon: " 24 Kcal")
        label.backgroundColor = .black
        return label
    }()
    lazy var todayImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    var playButton: SocialButton = {
        let button = SocialButton(image: UIImage(named: "play")!)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        [todayImage, firstLabel, secondLabel, playButton, thirdLabel, fourthLabel].forEach { contentView.addSubview($0)}
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
