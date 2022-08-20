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
                        textColor: DecaColor.black.color,
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
                        textColor: DecaColor.gray.color, numberOfLines: 1,
                        text: Constants.signinWith, kerning: nil))
    return label
}()
let dontHaveAnAccountLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 16, font: .poppinsMedium),
                        textColor: DecaColor.black.color, numberOfLines: 1,
                        text: Constants.noAccounttext, kerning: nil))
    return label
}()
// MARK: - Sign Up LABELS
var signupTitleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 26, font: .poppinsMedium),
                        textColor: DecaColor.black.color,
                        numberOfLines: 1, text: Constants.signUp, kerning: 0.5))
    label.textAlignment = .left
    return label
}()
let createPlanLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 26, font: .poppinsMedium).bold(), textColor: .white,
                        numberOfLines: 2, text: Constants.createPlan, kerning: 1.4))
    return label
}()
let alreadyHaveAnAccountLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 16, font: .poppinsMedium),
                        textColor: DecaColor.black.color, numberOfLines: 1,
                        text: Constants.yesAccount, kerning: nil))
    return label
}()
// Custom navbar
var navbarTitleLabel: UILabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 20, font: .poppinsRegular),
                        textColor: DecaColor.darkGray.color, numberOfLines: 1,
                        text: Constants.goodMorning, kerning: nil))
    return label
}()
// Input View Controller 
var inputVCTitleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 16, font: .poppinsMedium),
                        textColor: DecaColor.black.color,
                        numberOfLines: 1, text: Constants.limit, kerning: 0.2))
    label.textAlignment = .left
    label.sizeToFit()
    return label
}()
var inputVCSubTitleLabel: DecaLabel = {
    let label = DecaLabel()
    label.configure(with: DecaLabelViewModel(
                        font: decaFont(size: 12, font: .poppinsRegular),
                        textColor: DecaColor.gray.color,
                        numberOfLines: 1, text: Constants.inputvcSubt,
                        kerning: 0))
    label.textAlignment = .left
    return label
}()
