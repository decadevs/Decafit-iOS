//
//  InputViewController.swift
//  Decafit
//
//  Created by Decagon on 29/07/2022.
//

import UIKit

class InputViewController: UIViewController {
    static let shared =  InputViewController()
    lazy var topImageView = TodaySessionView(isHidden: true)
    lazy var labelStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews:
                                [inputVCTitleLabel, inputVCSubTitleLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.contentHuggingPriority(for: .vertical)
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupSubviews()
        nextButton.addTarget(self, action: #selector(gotoStartWorkout),
                             for: .touchUpInside)
        backButton.addTarget(self, action: #selector(clickNavBackButton),
                             for: .touchUpInside)
    }
}
extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @objc func gotoStartWorkout() {
        let screen = StartWorkoutViewController.getWorkoutView()
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension InputViewController: UIGestureRecognizerDelegate {
    func setupNavigation() {
        let navbarFrame = CGRect(x: 20, y: 200, width: view.bounds.width-40, height: 150)
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
}
extension InputViewController {
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
            nextButton.heightAnchor.constraint(equalToConstant: 64),
            setsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            repsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nextButton.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
