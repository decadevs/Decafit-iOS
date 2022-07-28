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
            firstLabel.text = todayCell?.bodyPart ?? ""
            secondLabel.text = todayCell?.duration
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
                            backgroundColor: .gray, titleColor: .white, image: <#T##UIImage?#>, borderWidth: <#T##CGFloat?#>, cornerRadius: <#T##CGFloat?#>, borderColor: <#T##CGColor?#>, contentEdgeInsets: <#T##UIEdgeInsets?#>, isEnabled: <#T##Bool#>, tarmic: <#T##Bool#>))
        return button
    }()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 4
        image.backgroundColor = .red
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.layer.masksToBounds = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        backgroundColor = .white
        [imageView, firstLabel, secondLabel].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalToConstant: 106),
            imageView.widthAnchor.constraint(equalToConstant: 154)
        ])
    }
}
