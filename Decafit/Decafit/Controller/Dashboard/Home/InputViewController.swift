//
//  InputViewController.swift
//  Decafit
//
//  Created by Decagon on 29/07/2022.
//

import UIKit

class InputViewController: UIViewController, UIGestureRecognizerDelegate {
    static let shared =  InputViewController()
    // MARK: - Image View
    lazy var topImageView = TodaySessionView(isHidden: true)
    // MARK: - Title field
    var titleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 16, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "Set your limit", kerning: 0.2))
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
                            kerning: 0))
        label.textAlignment = .left
        return label
    }()
    lazy var labelStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.contentHuggingPriority(for: .vertical)
        return stack
    }()
    // MARK: - Sets TextField
    var setsTextField: UITextField = createTextField(text: "Number of sets",
                                                font: decaFont(size: 16, font: .poppinsRegular))
    var repsTextField: UITextField = createTextField(text: "Number of reps",
                                                font: decaFont(size: 16, font: .poppinsRegular))
    // MARK: - Next Button
    var nextButton: DecaButton = {
        let button = createPurpleButton(title: "Next")
        button.addTarget(self, action: #selector(gotoStartWorkout), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupSubviews()
    }
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
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
    }
    func setupNavigation() {
        let navbarFrame = CGRect(x: 20, y: 200, width: view.bounds.width-40, height: 150)
        let backButton: SocialButton = {
            let btn = SocialButton(image: UIImage(named: "back-arrow")!)
            btn.backgroundColor = DecaColor.decafitLightGray.color
            btn.layer.cornerRadius = 10
            btn.layer.borderWidth = 0
            btn.contentEdgeInsets = UIEdgeInsets(
                top: 12, left: 12, bottom: 12, right: 12)
            btn.addTarget(self,
                          action: #selector(clickNavBackButton), for: .touchUpInside)
            return btn
        }()
        let inputNav: UIView = {
           let nav = UIView()
            nav.frame = navbarFrame
            nav.addSubview(backButton)
            backButton.frame = CGRect(x: 30, y: 40, width: 40, height: 40)
            return nav
        }()
        let navbar: UIBarButtonItem = UIBarButtonItem(customView: inputNav)
        navigationItem.leftBarButtonItems = [navbar]
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    func setupSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height/1.6)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         labelStack,
                                                         setsTextField, repsTextField, nextButton])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fillProportionally))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.widthAnchor.constraint(equalToConstant: view.frame.width-10),
            topImageView.heightAnchor.constraint(equalToConstant: 170),
            topImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            labelStack.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -20),
            labelStack.heightAnchor.constraint(equalToConstant: 45),
            labelStack.leadingAnchor.constraint(equalTo: setsTextField.leadingAnchor, constant: 0),
            setsTextField.heightAnchor.constraint(equalToConstant: 56),
            repsTextField.heightAnchor.constraint(equalToConstant: 56),
            setsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            repsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nextButton.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
