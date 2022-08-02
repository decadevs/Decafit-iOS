//
//  StartWorkoutCell.swift
//  Decafit
//
//  Created by Decagon on 01/08/2022.
//

import UIKit

class StartWorkoutCell: UITableViewCell {
    static let identifier = "StartWorkoutCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [exerciseImage, exerciseLabel, durationLabel].forEach { contentView.addSubview($0)}
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var exerciseLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 18, font: .poppinsMedium),
                                                 textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                                                 text: "Jumping Jacks", kerning: nil))
        return label
    }()
    var durationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 16, font: .poppinsMedium),
                                                 textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                                                 text: "X10", kerning: nil))
        return label
    }()
    lazy var exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        return image
    }()
    func configure(with model: StartWorkoutModel) {
        exerciseLabel.text = model.exerciseName
        durationLabel.text = model.duration
        exerciseImage.image = UIImage(named: model.image)
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 120),
            
            exerciseImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            exerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            exerciseImage.heightAnchor.constraint(equalToConstant: 56),
            exerciseImage.widthAnchor.constraint(equalToConstant: 64),

            
            exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 16),
            exerciseLabel.topAnchor.constraint(equalTo: exerciseImage.topAnchor, constant: 5),
//            exerciseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            
            durationLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 5),
            durationLabel.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor, constant: 0)
//            durationLabel.bottomAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: 5)
        ])
    }
}
