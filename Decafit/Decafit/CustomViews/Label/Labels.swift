//
//  Labels.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import UIKit
// MARK: - Login LABELS
let titleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 29, font: .poppinsMedium),
                        textColor: DecaColor.decafitBlack.color,
                        numberOfLines: 1, text: Constants.signIn, kerning: 0.5))
    label.textAlignment = .left
    return label
}()
let trackFitnessLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 38, font: .poppinsMedium), textColor: .white,
                        numberOfLines: 2, text: Constants.loginHeadertext, kerning: 1.3))
    return label
}()
let signInWithLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 13, font: .poppinsMedium),
                        textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                        text: Constants.signinWith, kerning: nil))
    return label
}()
let dontHaveAnAccountLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 16, font: .poppinsMedium),
                        textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                        text: Constants.noAccounttext, kerning: nil))
    return label
}()
// MARK: - Sign Up LABELS
var signupTitleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 29, font: .poppinsMedium),
                        textColor: DecaColor.decafitBlack.color,
                        numberOfLines: 1, text: Constants.signUp, kerning: 0.5))
    label.textAlignment = .left
    return label
}()
let createPlanLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 28, font: .poppinsMedium).bold(), textColor: .white,
                        numberOfLines: 2, text: Constants.createPlan, kerning: 1.4))
    return label
}()
let alreadyHaveAnAccountLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 16, font: .poppinsMedium),
                        textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                        text: Constants.yesAccount, kerning: nil))
    return label
}()
// Custom navbar
var navbarTitleLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 20, font: .poppinsRegular),
                        textColor: DecaColor.decafitDarkGray.color, numberOfLines: 1,
                        text: Constants.goodMorning, kerning: nil))
    return label
}()
// Input View Controller 
var inputVCTitleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 16, font: .poppinsMedium),
                        textColor: DecaColor.decafitBlack.color,
                        numberOfLines: 1, text: Constants.limit, kerning: 0.2))
    label.textAlignment = .left
    label.sizeToFit()
    return label
}()
var inputVCSubTitleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 12, font: .poppinsRegular),
                        textColor: DecaColor.decafitGray.color,
                        numberOfLines: 1, text: Constants.inputvcSubt,
                        kerning: 0))
    label.textAlignment = .left
    return label
}()
// Start Workout cell
var exerciseLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium).bold(),
                                             textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                                             text: Constants.exerciseLabelText, kerning: nil))
    return label
}()
var workoutDurationLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium),
                                             textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                                             text: Constants.workoutDurationLabelText, kerning: nil))
    return label
}()
// Focus Collection cell
var bodyFocusAreaLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 16, font: .poppinsMedium).bold(),
                                             textColor: .white, numberOfLines: 1,
                                             text: Constants.bodyFocusAreaText, kerning: 0.5))
    return label
}()
var focusDurationLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 12, font: .poppinsRegular),
                                             textColor: .white, numberOfLines: 1,
                                             text: Constants.focusDurationLabelText, kerning: 0.5))
    return label
}()
// MARK: - Focus area view title 
var focusAreaViewTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = Constants.focusAreaViewTitleText
    label.font = decaFont(size: 16, font: .poppinsMedium).bold()
    label.textColor = DecaColor.decafitBlack.color
    return label
}()
// MARK: - Today session view title
let todaySessionViewTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = Constants.todaySessionViewTitleText
    label.font = decaFont(size: 16, font: .poppinsMedium).bold()
    label.textColor = DecaColor.decafitBlack.color
    return label
}()
// MARK: - Today collection cell
let firstLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 24, font: .poppinsMedium).bold(),
                        textColor: .white, numberOfLines: 1,
                        text: Constants.todayFirstLabelText, kerning: 1.0))
    return label
}()
let secondLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 12, font: .poppinsRegular),
                                             textColor: .white, numberOfLines: 1,
                                             text: Constants.todaySecondLabelText, kerning: 0.5))
    return label
}()
let thirdLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                             textColor: .white, numberOfLines: 1,
                                             text: "", kerning: 0.5))
    label.attributedText = label.setAttributedText(
        image: Constants.clockImg,
        textAfterIcon: Constants.todayThirdLabelTextAfterIcon)
    return label
}()
let fourthLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsRegular),
                                             textColor: .white, numberOfLines: 1,
                                             text: "", kerning: 0.5))
    label.attributedText = label.setAttributedText(
        image: Constants.flameImg,
        textAfterIcon: Constants.todayFourthLabelTextAfterIcon)
    return label
}()
