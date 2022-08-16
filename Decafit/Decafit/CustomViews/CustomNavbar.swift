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
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    func setupSubviews() {
        [navbarProfileImage, navbarTitleLabel, navbarRightCalender].forEach { self.addSubview($0)}
        NSLayoutConstraint.activate([
            navbarProfileImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            navbarProfileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            navbarTitleLabel.leadingAnchor.constraint(equalTo: navbarProfileImage.trailingAnchor, constant: 25),
            navbarTitleLabel.topAnchor.constraint(equalTo: navbarProfileImage.topAnchor, constant: 15),
            navbarRightCalender.leadingAnchor.constraint(equalTo: navbarTitleLabel.trailingAnchor, constant: 70),
            navbarRightCalender.topAnchor.constraint(equalTo: navbarProfileImage.topAnchor, constant: 5)
        ])
    }
}
