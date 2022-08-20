//
//  FocusAreaCollectionViewCell.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
class FocusAreaCollectionViewCell: UICollectionViewCell {
    static let identifier = "WorkoutCell"
    var focusAreaCell: Workout? {
        didSet {
            guard focusAreaCell != nil else {
                return
            }
            focusImage.image = UIImage(named: focusAreaCell?.backgroundImage ?? "")
            bodyFocusAreaLabel.text = focusAreaCell?.title ?? "ttt"
            focusDurationLabel.text = focusAreaCell?.duration ?? "kkk"
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let focusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addoverlay(color: DecaColor.purple.color)
        return image
    }()
    var bodyFocusAreaLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 16, font: .poppinsMedium).bold(),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: Constants.bodyFocusAreaText, kerning: 0.5))
        return label
    }()
    var focusDurationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 12, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: Constants.focusDurationLabelText, kerning: 0.5))
        return label
    }()
    func setupViews() {
        [focusImage, bodyFocusAreaLabel, focusDurationLabel].forEach { contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            focusImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            focusImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            focusImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bodyFocusAreaLabel.leadingAnchor.constraint(equalTo: focusImage.leadingAnchor, constant: 10),
            bodyFocusAreaLabel.bottomAnchor.constraint(equalTo: focusImage.bottomAnchor, constant: -20),
            focusDurationLabel.trailingAnchor.constraint(equalTo: focusImage.trailingAnchor, constant: -20),
            focusDurationLabel.bottomAnchor.constraint(equalTo: focusImage.bottomAnchor, constant: -20)

        ])
    }
}
