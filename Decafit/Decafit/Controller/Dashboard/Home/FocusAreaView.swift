//
//  FocusAreaView.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
protocol FocusAreaViewDelegate: AnyObject {
    func didDisplayInputScreen(_ screen: InputViewController)
}
struct FocusAreaModel {
    let image, bodyPart, duration: String
}
class FocusAreaView: UIView, UICollectionViewDataSource,
                     UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var delegate: TodaySessionViewDelegate?
    let data: [FocusAreaModel] = [
        FocusAreaModel(image: "fitness-img", bodyPart: "Back", duration: "20 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Abs", duration: "30 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Thigh", duration: "10 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Abs", duration: "30 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Thigh", duration: "10 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Butt", duration: "30 days")
    ]
    // MARK: - TitleLabel
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Other Focus Areas"
        label.font = decaFont(size: 16, font: .poppinsMedium).bold()
        label.textColor = DecaColor.decafitBlack.color
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSubviews() {
        collectionView.register(FocusAreaCollectionViewCell.self,
                             forCellWithReuseIdentifier: FocusAreaCollectionViewCell.identifier)
        [titleLabel, collectionView].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: FocusAreaCollectionViewCell.identifier,
                                                        for: indexPath) as?
                FocusAreaCollectionViewCell else { return UICollectionViewCell() }
        let workouts = data[indexPath.item]
        cell.focusAreaCell = workouts
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/2.3, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screen = InputViewController.shared
        delegate?.didDisplayInputScreen(screen)
    }
}
