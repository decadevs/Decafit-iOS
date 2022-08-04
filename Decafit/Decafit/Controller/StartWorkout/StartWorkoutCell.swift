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
        [exerciseImage, exerciseLabel, workoutDurationLabel].forEach { contentView.addSubview($0)}
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with model: StartWorkoutModel) {
        exerciseLabel.text = model.exerciseName
        workoutDurationLabel.text = model.duration
        exerciseImage.image = UIImage(named: model.image)
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 90),
            exerciseImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            exerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -100),
            exerciseImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: -40),
            exerciseLabel.topAnchor.constraint(equalTo: exerciseImage.topAnchor, constant: 5),
            exerciseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            workoutDurationLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 5),
            workoutDurationLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 0),
            workoutDurationLabel.bottomAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: 5)
        ])
    }
}
