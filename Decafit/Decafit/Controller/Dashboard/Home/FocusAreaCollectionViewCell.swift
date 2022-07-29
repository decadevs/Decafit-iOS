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
            imageView.image = UIImage(named: focusAreaCell?.image ?? "nnn")
            bodyFocusAreaLabel.text = focusAreaCell?.bodyPart ?? "ttt"
            durationLabel.text = focusAreaCell?.duration
        }
    }
    var bodyFocusAreaLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 18, font: .poppinsMedium).bold(),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "First", kerning: 0.5))
        return label
    }()
    var durationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium).bold(),
                                                 textColor: .white, numberOfLines: 1,
                                                 text: "Second", kerning: 0.5))
        return label
    }()
    lazy var labelStack: DecaStack = {
        let stack = DecaStack(arrangedSubviews: [bodyFocusAreaLabel, durationLabel])
        stack.configure(with: DecaStackViewModel(
                            axis: .horizontal, alignment: .center,
                            spacing: 5, distribution: .equalSpacing))
        return stack
    }()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addSubview(labelStack)
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
        [imageView].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 106),
            imageView.widthAnchor.constraint(equalToConstant: 154),
            labelStack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            labelStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            labelStack.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10)
        ])
    }
}
