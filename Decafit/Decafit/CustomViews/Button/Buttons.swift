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
let signUpButton = DecaButton.createPurpleButton(title: Constants.signUp)
let orangeSignInLink = DecaButton.createOrangeButtonLink(title: Constants.signIn)
// MARK: - Custom navbar calender button
var navbarRightCalender: UIButton = {
   let btn = UIButton()
    btn.setImage(UIImage(named: Constants.calenderImg)!, for: .normal)
    btn.imageView?.addoverlay(color: DecaColor.decafitPalePurple.color)
    btn.backgroundColor = DecaColor.decafitLightGray.color
    btn.layer.cornerRadius = 10
    btn.layer.borderWidth = 0
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.contentEdgeInsets = UIEdgeInsets(
        top: 10, left: 12, bottom: 10, right: 12)
    return btn
}()
