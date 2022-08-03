//
//  FocusAreaCollectionViewCell.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
class FocusAreaCollectionViewCell: UICollectionViewCell {
    static let identifier = "WorkoutCell"
    var focusAreaCell: FocusAreaModel? {
        didSet {
            guard focusAreaCell != nil else {
                return
            }
            focusImage.image = UIImage(named: focusAreaCell?.image ?? "")
            bodyFocusAreaLabel.text = focusAreaCell?.bodyPart ?? "ttt"
            durationLabel.text = focusAreaCell?.duration ?? "kkk"
        }
    }
    var bodyFocusAreaLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 16, font: .poppinsMedium).bold(),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "First", kerning: 0.5))
        return label
    }()
    var durationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 12, font: .poppinsRegular),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Second", kerning: 0.5))
        return label
    }()
    lazy var focusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addoverlay(color: DecaColor.decafitPurple.color)
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        [focusImage, bodyFocusAreaLabel, durationLabel].forEach { contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            focusImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            focusImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            focusImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bodyFocusAreaLabel.leadingAnchor.constraint(equalTo: focusImage.leadingAnchor, constant: 10),
            bodyFocusAreaLabel.bottomAnchor.constraint(equalTo: focusImage.bottomAnchor, constant: -20),
            durationLabel.trailingAnchor.constraint(equalTo: focusImage.trailingAnchor, constant: -20),
            durationLabel.bottomAnchor.constraint(equalTo: focusImage.bottomAnchor, constant: -20)

        ])
    }
}
