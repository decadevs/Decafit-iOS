//
//  DecaTextField.swift
//  Decafit
//
//  Created by Decagon on 22/07/2022.
//

import UIKit

struct DecaTextFieldViewModel {
    let placeholder: String?
    weak var delegate: UITextFieldDelegate?
    let font: UIFont?
    let backgroundColor, tintColor: UIColor?
    let borderWidth, cornerRadius: CGFloat?
    let borderColor: CGColor?
    let isSecureEntry, isEnabled, tarmic: Bool
    let leftView, rightView: UIView?
    let leftViewMode, rightViewMode: UITextField.ViewMode?
}

final class DecaTextField: UITextField {
    let paddingLeft: CGFloat = 20
    var paddingRight: CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y,
                      width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    func configure(with viewModel: DecaTextFieldViewModel) {
        delegate = viewModel.delegate
        font = viewModel.font
        placeholder = viewModel.placeholder
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = viewModel.cornerRadius ?? 0
        layer.borderWidth = viewModel.borderWidth ?? 0
        translatesAutoresizingMaskIntoConstraints = viewModel.tarmic
        isEnabled = viewModel.isEnabled
        layer.borderColor = viewModel.borderColor
        isSecureTextEntry = viewModel.isSecureEntry
        tintColor = viewModel.tintColor
        leftView = viewModel.leftView
        rightView = viewModel.rightView
    }
}
func createTextField(text: String, font: UIFont) -> UITextField {
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        textField.placeholder = text
        textField.font = font
        textField.layer.borderWidth = 1
        textField.layer.borderColor = DecaColor.decafitGray.color.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    return textField
}
