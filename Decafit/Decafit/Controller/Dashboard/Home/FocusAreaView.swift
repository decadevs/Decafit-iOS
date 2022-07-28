//
//  FocusAreaView.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
struct FocusAreaModel {
    let image, bodyPart, duration: String?
}
class FocusAreaView: UIView, UICollectionViewDelegate,
                     UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let data: [FocusAreaModel] = [
        FocusAreaModel(image: "fitness-img", bodyPart: "Back", duration: "20 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Abs", duration: "30 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Thigh", duration: "10 days"),
        FocusAreaModel(image: "fitness-img", bodyPart: "Butt", duration: "30 days")
    ]
    // MARK: - TitleLabel
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Other Focus Areas"
        label.font = decaFont(size: 14, font: .poppinsMedium).bold()
        label.textColor = DecaColor.decafitBlack.color
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 3, left: 10, bottom: 0, right: 10)
        view.collectionViewLayout = layout
        view.backgroundColor = .red 
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
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: FocusAreaCollectionViewCell.identifier,
                                                        for: indexPath) as?
                FocusAreaCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .red
        let workouts = data[indexPath.item]
        cell.focusAreaCell = workouts
        print(cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/3 , height: 50)
    }
}
