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
                                image: "weightlift", contentMode: .scaleToFill,
                                tintColor: .white))
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    // MARK: - Title field
    var titleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 20, font: .poppinsMedium).bold(),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "Set your limit", kerning: 1))
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    var subTitleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsRegular),
                            textColor: DecaColor.decafitGray.color,
                            numberOfLines: 1, text: "Enter the number of sets and reps for your workout",
                            kerning: 0.1))
        label.textAlignment = .left
        return label
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
        button.addTarget(self, action: #selector(gotoStartWorkout), for: .touchUpInside)
        return button
    }()
    lazy var fieldStack: DecaStack = {
       let stack = DecaStack(arrangedSubviews: [setsTextField, repsTextField, nextButton])
        stack.configure(with: DecaStackViewModel(
                            axis: .vertical, alignment: .center,
                            spacing: 20, distribution: .fillEqually))
       return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        hidesBottomBarWhenPushed = true
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
extension InputViewController {
    @objc func gotoStartWorkout() {
        let screen = StartWorkoutViewController.getWorkoutView()
        self.navigationController?.pushViewController(screen, animated: true)
//        screen.modalPresentationStyle = .fullScreen
//        present(screen, animated: true)
    }
    func setupSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height/1.5)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         titleLabel, subTitleLabel,
                                                         fieldStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fillProportionally))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.widthAnchor.constraint(equalToConstant: view.frame.width-60),
            topImageView.heightAnchor.constraint(equalToConstant: 150),
            topImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 200),
            titleLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            fieldStack.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10),
            fieldStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            fieldStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            fieldStack.heightAnchor.constraint(equalToConstant: 150),
            setsTextField.heightAnchor.constraint(equalToConstant: 45),
            repsTextField.heightAnchor.constraint(equalToConstant: 45),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            setsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            repsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nextButton.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
