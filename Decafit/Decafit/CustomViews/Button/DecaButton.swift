//
//  DecaButton.swift
//  Decafit
//
//  Created by Decagon on 22/07/2022.
//

import UIKit
final class DecaButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    static func createSocialButton(image: String) -> Self {
        let btn = Self()
        btn.setImage(UIImage(named: image), for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 1
        btn.layer.borderColor =  DecaColor.decafitGray.color.cgColor
        btn.contentEdgeInsets = UIEdgeInsets(
            top: 14, left: 16, bottom: 14, right: 16)
        return btn
    }
    static func createPurpleButton(title: String) -> Self {
        let btn = Self()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = decaFont(size: 24, font: .ubuntuMedium)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = DecaColor.decafitPurple.color
        btn.layer.cornerRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return btn
    }
    static func createOrangeButtonLink(title: String) -> Self {
        let btn = Self()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = decaFont(size: 16, font: .poppinsRegular)
        btn.setTitleColor(DecaColor.decafitOrange.color, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }
}
