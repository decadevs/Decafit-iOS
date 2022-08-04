//
//  DecaStack.swift
//  Decafit
//
//  Created by Decagon on 25/07/2022.
//

import UIKit

struct DecaStackViewModel {
    let axis: NSLayoutConstraint.Axis
    let alignment: UIStackView.Alignment
    let spacing: CGFloat?
    let distribution: UIStackView.Distribution?
}

final class DecaStack: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    func configure(with viewModel: DecaStackViewModel) {
        axis = viewModel.axis
        alignment = viewModel.alignment
        spacing = viewModel.spacing ?? 0
        distribution = viewModel.distribution ?? .fill
    }
}
