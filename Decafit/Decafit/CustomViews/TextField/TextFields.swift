//
//  InputFields.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import UIKit
// MARK: - LoginVC Input Fields
let emailTextField: DecaTextField =
    DecaTextField.createNormalTextField(text: Constants.emailHolder)
let passwordTextField: DecaTextField =
    DecaTextField.createSecureTextField(text: Constants.pswHolder)
// MARK: - Signup VC Input Fields

// MARK: - Sets TextField
let setsTextField: DecaTextField =
    DecaTextField.createNormalTextField(text: Constants.sets)
let repsTextField: DecaTextField
    = DecaTextField.createNormalTextField(text: Constants.reps)
