//
//  DecaLabel.swift
//  Decafit
//
//  Created by Decagon on 25/07/2022.
//

import UIKit
struct DecaLabelViewModel {
    let tarmic: Bool = false
    let font: UIFont
    let textColor: UIColor
    let numberOfLines: Int
    let text: String
    let kerning: CGFloat?
}

final class DecaLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    func configure(with viewModel: DecaLabelViewModel) {
        translatesAutoresizingMaskIntoConstraints = viewModel.tarmic
        font = viewModel.font
        text = viewModel.text
        numberOfLines = viewModel.numberOfLines
        textColor = viewModel.textColor
        set(text: viewModel.text, withKerning: viewModel.kerning ?? 0)
    }
}
