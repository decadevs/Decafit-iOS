//
//  CustomView.swift
//  Decafit
//
//  Created by Decagon on 01/08/2022.
//

import UIKit
class CustomNavbar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var titleLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 18, font: .poppinsMedium),
                                                 textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                                                 text: "Good Morning", kerning: nil))
        return label
    }()
    // MARK: - Image View
    lazy var profileImage: DecaImageView = {
        let imageView = DecaImageView(frame: .zero)
        imageView.configure(with: DecaImageViewModel(
                                image: "profile", contentMode: .scaleAspectFit,
                                tintColor: .clear))
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    var notificationButton: SocialButton = {
        let button = SocialButton(image: UIImage(named: "bell-icon")!)
        button.backgroundColor = DecaColor.decafitLightGray.color
        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 0.1
        button.contentEdgeInsets = UIEdgeInsets(
            top: 10, left: 12, bottom: 10, right: 12)
        return button
    }()
    func setupSubviews() {
        [profileImage, titleLabel, notificationButton].forEach { self.addSubview($0)}
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            // title
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 15),
            // bell icon
            notificationButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 100),
            notificationButton.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 5)
//            notificationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
}
