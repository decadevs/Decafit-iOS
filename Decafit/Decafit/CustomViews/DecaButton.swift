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

final class DecaButton: UIButton {

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
