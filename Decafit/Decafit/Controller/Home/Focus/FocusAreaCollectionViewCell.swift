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
