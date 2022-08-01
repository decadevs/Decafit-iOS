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
            imageView.image = UIImage(named: focusAreaCell?.image ?? "")
            bodyFocusAreaLabel.text = focusAreaCell?.bodyPart ?? "tttkkkkkk"
            durationLabel.text = focusAreaCell?.duration ?? "kkkkkkk"
        }
    }
    var bodyFocusAreaLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 30, font: .poppinsMedium).bold(),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "First", kerning: 0.5))
        label.backgroundColor = .red
        return label
    }()
    var durationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 30, font: .poppinsMedium).bold(),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Second", kerning: 0.5))
        return label
    }()
    lazy var labelStack: DecaStack = {
        let stack = DecaStack(arrangedSubviews: [bodyFocusAreaLabel, durationLabel])
        stack.configure(with: DecaStackViewModel(
                            axis: .horizontal, alignment: .center,
                            spacing: 5, distribution: .fillEqually))
        stack.backgroundColor = .systemTeal
        return stack
    }()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addSubview(bodyFocusAreaLabel)
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
        [imageView, labelStack].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 106),
            imageView.widthAnchor.constraint(equalToConstant: 154),
//            labelStack.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
//            labelStack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
//            labelStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 30),
//            labelStack.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -80)
        ])
    }
}
