//
//  TodayCollectionViewCell.swift
//  Decafit
//
//  Created by Decagon on 28/07/2022.
//
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
