//
//  TodaySession.swift
//  Decafit
//
//  Created by Decagon on 28/07/2022.
//
import UIKit
struct TodaySessionModel {
let image, bodyPart, duration: String?
}
class TodaySessionView: UIView, UICollectionViewDelegate,
                 UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let data: [TodaySessionModel] = [
        TodaySessionModel(image: "fitness-img", bodyPart: "Back", duration: "20 days"),
        TodaySessionModel(image: "signup-img", bodyPart: "Abs", duration: "30 days")
    ]
    // MARK: - TitleLabel
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today's session"
        label.font = decaFont(size: 14, font: .poppinsMedium).bold()
        label.textColor = DecaColor.decafitBlack.color
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 11, left: 0, bottom: -10, right: 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 3, left: 16, bottom: 0, right: 16)
        view.collectionViewLayout = layout
        view.backgroundColor = .blue
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
        [titleLabel, collectionView].forEach { self.addSubview($0) }
        collectionView.register(TodayCollectionViewCell.self,
                             forCellWithReuseIdentifier: TodayCollectionViewCell.identifier)
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
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: TodayCollectionViewCell.identifier,
                                                        for: indexPath) as?
                TodayCollectionViewCell else { return UICollectionViewCell() }
        let todayWorkouts = data[indexPath.item]
        cell.todayCell = todayWorkouts
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/3, height: 50)
    }
}
