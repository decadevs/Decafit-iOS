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
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 20, font: .poppinsRegular),
                                                 textColor: DecaColor.decafitDarkGray.color, numberOfLines: 1,
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
    var calenderButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "calender")!, for: .normal)
        btn.imageView?.addoverlay(color: DecaColor.decafitPalePurple.color)
        btn.backgroundColor = DecaColor.decafitLightGray.color
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 0
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 10, left: 12, bottom: 10, right: 12)
        return btn
    }()
    func setupSubviews() {
        [profileImage, titleLabel, calenderButton].forEach { self.addSubview($0)}
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 15),
            calenderButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 100),
            calenderButton.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 2)
        ])
    }
}
