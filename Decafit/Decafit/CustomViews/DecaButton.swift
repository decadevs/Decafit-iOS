//
//  DecaButton.swift
//  Decafit
//
//  Created by Decagon on 22/07/2022.
//

import UIKit

struct DecaButtonViewModel {
    let title: String?
    let font: UIFont?
    let backgroundColor, titleColor: UIColor?
    let image: UIImage?
    let borderWidth, cornerRadius: CGFloat?
    let borderColor: CGColor?
    let contentEdgeInsets: UIEdgeInsets?
    let isEnabled, tarmic: Bool
}

class DecaButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with viewModel: DecaButtonViewModel) {
        setTitle(viewModel.title, for: .normal)
        titleLabel?.font = viewModel.font
        setTitleColor(viewModel.titleColor, for: .normal)
        setImage(viewModel.image, for: .normal)
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = viewModel.cornerRadius ?? 0
        layer.borderWidth = viewModel.borderWidth ?? 0
        translatesAutoresizingMaskIntoConstraints = viewModel.tarmic
        isEnabled = viewModel.isEnabled
        layer.borderColor = viewModel.borderColor
        contentEdgeInsets = viewModel.contentEdgeInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
class SocialButton: DecaButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle(nil, for: .normal)
        titleLabel?.font = nil
        setTitleColor(nil, for: .normal)
        backgroundColor = nil
        layer.cornerRadius = 3
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
        isEnabled = true
        layer.borderColor =  DecaColor.decafitGray.color.cgColor
        contentEdgeInsets = UIEdgeInsets(
            top: 14, left: 16, bottom: 14, right: 16)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        setImage(image, for: .normal)
    }
}
