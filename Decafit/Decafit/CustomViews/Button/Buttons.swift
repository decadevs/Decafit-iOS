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
let backButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: Constants.backArrow), for: .normal)
    button.backgroundColor = DecaColor.decafitLightGray.color
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 0
    button.contentEdgeInsets = UIEdgeInsets(
        top: 12, left: 12, bottom: 12, right: 12)
    return button
}()
// Start workout top view
let startWorkoutButton: DecaButton = {
    let button = DecaButton.createPurpleButton(title: "Start Workout")
    button.layer.shadowOffset = CGSize(width: 0, height: 8)
    button.layer.shadowOpacity = 0.1
    return button
}()
