//
//  DecaImageView.swift
//  Decafit
//
//  Created by Decagon on 25/07/2022.
//

import UIKit
struct DecaImageViewModel {
    let tarmic: Bool = false
    let image: String
    let contentMode: UIView.ContentMode
    let tintColor: UIColor
}

final class DecaImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    func configure(with viewModel: DecaImageViewModel) {
        translatesAutoresizingMaskIntoConstraints = viewModel.tarmic
        image = UIImage(named: viewModel.image)
        contentMode = viewModel.contentMode
        tintColor = viewModel.tintColor
    }    
}
