//
//  FocusAreaCollectionViewCell.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
import Kingfisher

class FocusAreaCollectionViewCell: UICollectionViewCell {
    static let identifier = "WorkoutCell"
    var focusAreaCell: WorkoutListQuery.Data.Workout? {
        didSet {
            workoutTitle.text = focusAreaCell?.title
            focusDurationLabel.text = "30 days"
            DispatchQueue.main.async { [weak self] in
                let placeholder = UIImage(named: "back")
                let url = URL(string: self?.focusAreaCell?.backgroundImage ?? "back")
                self?.workoutImage.kf.indicatorType = .activity
                self?.workoutImage.kf.setImage(with: url, placeholder: placeholder, options: nil, completionHandler: nil)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    let workoutImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addoverlay(color: DecaColor.purple.color)
        return image
    }()
    var workoutTitle: UILabel = {
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
        [workoutImage, workoutTitle, focusDurationLabel].forEach { contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            workoutImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            workoutImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            workoutImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            workoutImage.widthAnchor.constraint(equalToConstant: 162.5),
            workoutImage.heightAnchor.constraint(equalToConstant: 120),

            workoutTitle.leadingAnchor.constraint(equalTo: workoutImage.leadingAnchor, constant: 5),
            workoutTitle.bottomAnchor.constraint(equalTo: workoutImage.bottomAnchor, constant: -15),
            focusDurationLabel.trailingAnchor.constraint(equalTo: workoutImage.trailingAnchor, constant: -5),
            focusDurationLabel.bottomAnchor.constraint(equalTo: workoutImage.bottomAnchor, constant: -5)

        ])
    }
}
