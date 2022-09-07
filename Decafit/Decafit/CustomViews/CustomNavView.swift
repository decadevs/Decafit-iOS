//
//  CustomView.swift
//  Decafit
//
//  Created by Decagon on 01/08/2022.
//

import UIKit

class CustomNavView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()

    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    var navProfileImageBtn: DecaButton = {
       let btn = DecaButton()
        btn.configure(with: DecaButtonViewModel(
                        title: nil, font: nil, backgroundColor: nil,
                        titleColor: nil, image: UIImage(named: Constants.profileImg), borderWidth: 0,
                        cornerRadius: 10, borderColor: nil,
                        contentEdgeInsets: UIEdgeInsets(
                            top: 10, left: 12, bottom: 10, right: 12),
                        isEnabled: true, tarmic: false))
        btn.tag = Tags.navProfileImageBtn
//        btn.imageView?.addoverlay(color: DecaColor.palePurple.color)
        return btn
    }()
    var navbarRightCalender: DecaButton = {
       let btn = DecaButton()
        btn.configure(with: DecaButtonViewModel(
                        title: nil, font: nil, backgroundColor: DecaColor.lightGray.color,
                        titleColor: nil, image: UIImage(named: Constants.calenderImg), borderWidth: 0,
                        cornerRadius: 10, borderColor: nil,
                        contentEdgeInsets: UIEdgeInsets(
                            top: 10, left: 12, bottom: 10, right: 12),
                        isEnabled: true, tarmic: false))
//        btn.imageView?.addoverlay(color: DecaColor.palePurple.color)
        return btn
    }()

    func setupSubviews() {
        [navProfileImageBtn, navbarTitleLabel, navbarRightCalender].forEach { self.addSubview($0)}
        NSLayoutConstraint.activate([
            navProfileImageBtn.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            navProfileImageBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            navbarTitleLabel.leadingAnchor.constraint(equalTo: navProfileImageBtn.trailingAnchor, constant: 15),
            navbarTitleLabel.topAnchor.constraint(equalTo: navProfileImageBtn.topAnchor, constant: 25),
            navbarRightCalender.leadingAnchor.constraint(equalTo: navbarTitleLabel.trailingAnchor, constant: 60),
            navbarRightCalender.topAnchor.constraint(equalTo: navProfileImageBtn.topAnchor, constant: 15)
        ])
    }
}
