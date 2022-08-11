//
//  Images.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import UIKit
// MARK: - Login Top Image View
let topImageView: DecaImageView = {
    let imageView = DecaImageView(frame: .zero)
    imageView.configure(with: DecaImageViewModel(
                            image: Constants.fitnessImg,
                            contentMode: .scaleAspectFill,
                            tintColor: .white))
    imageView.addSubview(trackFitnessLabel)
    return imageView
}()
// MARK: - Signup Top Image View
let signupTopImageView: DecaImageView = {
    let imageView = DecaImageView(frame: .zero)
    imageView.configure(with: DecaImageViewModel(
                            image: Constants.signupImg,
                            contentMode: .scaleToFill,
                            tintColor: .white))
    imageView.addSubview(createPlanLabel)
    return imageView
}()
// MARK: - Custom navbar Profile Image View
let navbarProfileImage: DecaImageView = {
    let imageView = DecaImageView(frame: .zero)
    imageView.configure(with: DecaImageViewModel(
                            image: Constants.profileImg,
                            contentMode: .scaleAspectFit,
                            tintColor: .clear))
    imageView.layer.cornerRadius = 10
    return imageView
}()
