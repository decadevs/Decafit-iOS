//
//  Buttons.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import UIKit
// MARK: - Buttons
let loginButton: DecaButton = DecaButton.createPurpleButton(title: Constants.signIn)
let googleButton = DecaButton.createSocialButton(image: Constants.googleImg)
let facebookButton = DecaButton.createSocialButton(image: Constants.fbImg)
let appleButton = DecaButton.createSocialButton(image: Constants.appleImg)
let orangeSignUpLink = DecaButton.createOrangeButtonLink(title: Constants.signUp)
let nextButton = DecaButton.createPurpleButton(title: Constants.next)

let backButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: Constants.backArrow), for: .normal)
    button.backgroundColor = DecaColor.lightGray.color
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 0
    button.contentEdgeInsets = UIEdgeInsets(
        top: 12, left: 12, bottom: 12, right: 12)
    return button
}()
