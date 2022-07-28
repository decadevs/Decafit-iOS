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
            bodyFocusAreaLabel.text = focusAreaCell?.bodyPart ?? ""
            durationLabel.text = focusAreaCell?.duration
        }
    }
    var bodyFocusAreaLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium).bold(),
                                                 textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                                                 text: "First", kerning: 0.5))
        return label
    }()
    var durationLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium).bold(),
                                                 textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
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
        image.layer.cornerRadius = 4
        image.backgroundColor = .red
        image.addSubview(labelStack)
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        backgroundColor = .white
        [imageView].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 106),
            imageView.widthAnchor.constraint(equalToConstant: 154),
            labelStack.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            labelStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10)
        ])
    }
}
