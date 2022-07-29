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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
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
