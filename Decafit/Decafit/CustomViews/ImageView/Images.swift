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
                            contentMode: .scaleAspectFit,
                            tintColor: .white))
    imageView.addSubview(trackFitnessLabel)
    return imageView
}()
// MARK: - Signup Top Image View
let signupTopImageView: DecaImageView = {
    let imageView = DecaImageView(frame: .zero)
    imageView.configure(with: DecaImageViewModel(
                            image: Constants.signupImg,
                            contentMode: .scaleAspectFit,
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
// MARK: - Start Workout cell image
let exerciseImage: DecaImageView = {
    let img = DecaImageView(frame: .zero)
    img.contentMode = .scaleAspectFit
    img.layer.cornerRadius = 10
    return img
}()
// MARK: - Focus Cell Image
let focusImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 10
    image.addoverlay(color: DecaColor.decafitPurple.color)
    return image
}()
// MARK: - Today Cell Image
let todayImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 10
    image.addoverlay(color: DecaColor.decafitPurple.color)
    return image
}()
