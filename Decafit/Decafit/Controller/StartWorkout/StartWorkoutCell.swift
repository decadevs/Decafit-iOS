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
        [exerciseImage, exerciseLabel, durationLabel, completeButton].forEach { contentView.addSubview($0)}
        setupSubviews()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var exerciseLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 18, font: .poppinsMedium),
                                                 textColor: DecaColor.black.color, numberOfLines: 1,
                                                 text: "Jumping Jacks", kerning: nil))
        return label
    }()
    var durationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 16, font: .poppinsMedium),
                                                 textColor: DecaColor.gray.color, numberOfLines: 1,
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
    lazy var completeButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("complete", for: .normal)
        btn.titleLabel?.font = decaFont(size: 12, font: .poppinsMedium)
        btn.setTitleColor(DecaColor.decafitGreen.color, for: .normal)
        btn.backgroundColor = DecaColor.decafitLightGreen.color
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 0
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 13, left: 12, bottom: 13, right: 12)
        return btn
    }()
    func configure(with model: StartWorkoutModel) {
        exerciseLabel.text = model.exerciseName
        durationLabel.text = model.duration
        exerciseImage.image = UIImage(named: model.image)
    }
    func setupSubviews() {
        completeButton.isHidden = true
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 120),
            
            exerciseImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            exerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            exerciseImage.heightAnchor.constraint(equalToConstant: 56),
            exerciseImage.widthAnchor.constraint(equalToConstant: 64),

            exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 16),
            exerciseLabel.topAnchor.constraint(equalTo: exerciseImage.topAnchor, constant: 5),
            completeButton.topAnchor.constraint(equalTo: exerciseLabel.topAnchor, constant: 5),
            completeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            completeButton.widthAnchor.constraint(equalToConstant: 95),
            completeButton.heightAnchor.constraint(equalToConstant: 33),
            durationLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 5),
            durationLabel.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor, constant: 0)
        ])
    }
}
