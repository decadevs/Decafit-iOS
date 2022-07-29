//
//  InputViewController.swift
//  Decafit
//
//  Created by Decagon on 29/07/2022.
//

import UIKit

class InputViewController: UIViewController {
    static let shared =  InputViewController()
    // MARK: - Image View
    lazy var topImageView: DecaImageView = {
        let imageView = DecaImageView(frame: .zero)
        imageView.configure(with: DecaImageViewModel(
                                image: "fitness-img", contentMode: .scaleAspectFit,
                                tintColor: .white))
//        imageView.addSubview()
        return imageView
    }()
    // MARK: - Title field
    var titleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 29, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "Set your limit", kerning: 1))
        label.textAlignment = .left
        return label
    }()
    var subTitleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsRegular),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "Enter the number of sets and reps for your workout",
                            kerning: 0.5))
        label.textAlignment = .left
        return label
    }()
    lazy var titleStack: DecaStack = {
       let stack = DecaStack(arrangedSubviews: [titleLabel, subTitleLabel])
        stack.configure(with: DecaStackViewModel(
                            axis: .vertical, alignment: .leading,
                            spacing: 10, distribution: .fillProportionally))
       return stack
    }()
    // MARK: - Sets TextField
    var setsTextField: UITextField = createTextField(text: "Number of sets",
                                                font: decaFont(size: 16, font: .poppinsRegular))
    var repsTextField: UITextField = createTextField(text: "Number of reps",
                                                font: decaFont(size: 16, font: .poppinsRegular))
    // MARK: - Next Button
    lazy var nextButton: DecaButton = {
        let button = DecaButton()
        button.configure(with: DecaButtonViewModel(
                            title: "Next",
                            font: decaFont(size: 24, font: .ubuntuMedium),
                            backgroundColor: DecaColor.decafitPurple.color,
                            titleColor: .white, image: nil, borderWidth: nil,
                            cornerRadius: 5, borderColor: nil,
                            contentEdgeInsets: nil, isEnabled: true, tarmic: false))
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    lazy var titleStack: DecaStack = {
       let stack = DecaStack(arrangedSubviews: [titleLabel, subTitleLabel])
        stack.configure(with: DecaStackViewModel(
                            axis: .vertical, alignment: .leading,
                            spacing: 10, distribution: .fillProportionally))
       return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
}
extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
extension InputViewController {
    func setupSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height-30)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         titleStack,
                                                         setsTextField, repsTextField, nextButton])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 10, distribution: .fillEqually))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.widthAnchor.constraint(equalToConstant: view.frame.width-20),
            topImageView.heightAnchor.constraint(equalToConstant: 180),
            topImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            setsTextField.heightAnchor.constraint(equalToConstant: 56),
            repsTextField.heightAnchor.constraint(equalToConstant: 56),
            nextButton.heightAnchor.constraint(equalToConstant: 64),
            setsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            repsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nextButton.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
