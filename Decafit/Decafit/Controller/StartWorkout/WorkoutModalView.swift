//
//  WorkoutModalView.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import UIKit

class WorkoutModalView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        isHidden = true 
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var workoutModalImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: ""))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = DecaColor.decafitLightGray.color
        return image
    }()
    lazy var workoutModalTitle: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 20, font: .poppinsMedium),
                            textColor: .black, numberOfLines: 1,
                            text: "Jumping Jacks", kerning: 1.0))
        return label
    }()
    lazy var workoutModalTextview: UILabel = {
        let label = DecaLabel()
        let txt = modalText()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 12, font: .poppinsRegular),
                            textColor: DecaColor.decafitDarkGray.color, numberOfLines: 0,
                            text: txt, kerning: nil))
        return label
    }()
    var workoutModalButton: DecaButton = {
        let btn = DecaButton()
        btn.layer.borderColor =  DecaColor.decafitLightGray.color.cgColor
        btn.configure(with: DecaButtonViewModel(
                        title: "Close",
                        font: decaFont(size: 14, font: .poppinsRegular),
                        backgroundColor: .clear,
                        titleColor: DecaColor.decafitPurple.color,
                        image: nil, borderWidth: 1, cornerRadius: 4,
                        borderColor: DecaColor.decafitPurple.color.cgColor,
                        contentEdgeInsets: nil, isEnabled: true, tarmic: false))
        return btn
    }()
    func setupSubviews() {
        [workoutModalImage, workoutModalTitle, workoutModalTextview, workoutModalButton].forEach { addSubview($0)}
        NSLayoutConstraint.activate([
            workoutModalImage.topAnchor.constraint(equalTo: topAnchor),
            workoutModalImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            workoutModalImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            workoutModalImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            workoutModalImage.widthAnchor.constraint(equalTo: widthAnchor),
            workoutModalTitle.topAnchor.constraint(equalTo: workoutModalImage.bottomAnchor, constant: 15),
            workoutModalTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutModalTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            workoutModalTextview.topAnchor.constraint(equalTo: workoutModalTitle.bottomAnchor),
            
            workoutModalTextview.leadingAnchor.constraint(equalTo: workoutModalTitle.leadingAnchor, constant: 0),
            workoutModalTextview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            workoutModalTextview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            workoutModalButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            workoutModalButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            workoutModalButton.heightAnchor.constraint(equalToConstant: 38),
            workoutModalButton.widthAnchor.constraint(equalToConstant: 104)
        ])
    }
}
extension WorkoutModalView {
    func modalText() -> String {
        let text1 = "Lorem ipsum dolor sit amet, consetetur elitr, sed diam nonumy eirmod tempor invidunt labore et"
        let text2 = "dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet"
        let text3 = "clita kasd gubergren, sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet"
        let text = text1 + text2 + text3
        return text
    }
}
