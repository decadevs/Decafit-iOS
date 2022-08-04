//
//  DecaTextField.swift
//  Decafit
//
//  Created by Decagon on 22/07/2022.
//

import UIKit
final class DecaTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        autocapitalizationType = .none
        backgroundColor = .clear
        font = decaFont(size: 16, font: .poppinsRegular)
        layer.borderWidth = 1
        textColor = DecaColor.decafitDarkGray.color
        layer.cornerRadius = 5
        layer.borderColor = DecaColor.decafitDarkGray.color.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    static func createNormalTextField(text: String) -> Self {
        let field = Self()
        field.placeholder = text
        return field
    }
    static func createSecureTextField(text: String) -> Self {
        let field = Self()
        field.placeholder = text
        field.isSecureTextEntry = true
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: field.frame.height))
        field.rightViewMode = .always
        return field
    }
}
