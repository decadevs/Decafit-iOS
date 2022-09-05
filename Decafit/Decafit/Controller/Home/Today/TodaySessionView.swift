//
//  TodaySession.swift
//  Decafit
//
//  Created by Decagon on 28/07/2022.
//
import UIKit
class TodaySessionView: UIView {
    let data = DataManager.shared
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(TodayCollectionViewCell.self,
                             forCellWithReuseIdentifier: TodayCollectionViewCell.identifier)
        return view
    }()
    let todaySessionViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.todaySessionViewTitleText
        label.font = decaFont(size: 16, font: .poppinsMedium).bold()
        label.textColor = DecaColor.black.color
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupSubviews()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    convenience init(isHidden: Bool) {
        self.init()
        todaySessionViewTitle.isHidden = isHidden
    }
    func setupSubviews() {
        [todaySessionViewTitle, collectionView].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            todaySessionViewTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            todaySessionViewTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            collectionView.topAnchor.constraint(equalTo: todaySessionViewTitle.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
extension TodaySessionView: UICollectionViewDelegate,
                            UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.getTodayData().count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: TodayCollectionViewCell.identifier,
                                                        for: indexPath) as?
                TodayCollectionViewCell else { return UICollectionViewCell() }
        let todayWorkouts = data.getTodayData()[indexPath.item]
        cell.todayCell = todayWorkouts
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
