//
//  TodayCollectionViewCell.swift
//  Decafit
//
//  Created by Decagon on 28/07/2022.
//
import UIKit
class TodayCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodayCell"
    var todayCell: TodaySessionModel? {
        didSet {
            guard todayCell != nil else {
                return
            }
            imageView.image = UIImage(named: todayCell?.image ?? "")
            firstLabel.text = todayCell?.title ?? ""
            secondLabel.text = todayCell?.name
            timeButton.setTitle(todayCell?.time, for: .normal)
            calorieButton.setTitle(todayCell?.calorie, for: .normal)
        }
    }
    lazy var firstLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium).bold(),
                                                 textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                                                 text: "First", kerning: 0.5))
        return label
    }()
    lazy var secondLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(font: decaFont(size: 14, font: .poppinsMedium).bold(),
                                                 textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                                                 text: "Second", kerning: 0.5))
        return label
    }()
    lazy var timeButton: DecaButton = {
        let button = DecaButton()
        button.configure(with: DecaButtonViewModel(
                            title: "24 min", font: decaFont(size: 12, font: .poppinsRegular),
                            backgroundColor: .gray, titleColor: .white,
                            image: UIImage(systemName: "clock"), borderWidth: 1,
                            cornerRadius: 7, borderColor: nil, contentEdgeInsets: nil,
                            isEnabled: false, tarmic: true))
        return button
    }()
    lazy var calorieButton: DecaButton = {
        let button = DecaButton()
        button.configure(with: DecaButtonViewModel(
                            title: "24 Kcal", font: decaFont(size: 12, font: .poppinsRegular),
                            backgroundColor: .gray, titleColor: .white,
                            image: UIImage(systemName: "flame.fill"), borderWidth: 1,
                            cornerRadius: 7, borderColor: nil, contentEdgeInsets: nil,
                            isEnabled: false, tarmic: true))
        return button
    }()
    lazy var buttonStack: DecaStack = {
        let stack = DecaStack(arrangedSubviews: [timeButton, calorieButton])
        stack.configure(with: DecaStackViewModel(
                            axis: .horizontal, alignment: .center,
                            spacing: 5, distribution: .equalSpacing))
        return stack
    }()
    lazy var allStack: DecaStack = {
        let stack = DecaStack(arrangedSubviews: [firstLabel, secondLabel, buttonStack])
        stack.configure(with: DecaStackViewModel(
                            axis: .vertical, alignment: .leading,
                            spacing: 10, distribution: .equalSpacing))
        return stack
    }()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.addSubview(allStack)
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            allStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5),
            allStack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            allStack.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
