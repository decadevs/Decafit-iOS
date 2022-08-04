//
//  FocusAreaView.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit
protocol FocusAreaViewDelegate: AnyObject {
    func didDisplayInputScreen(_ screen: FitConfigViewController)
}
class FocusAreaView: UIView, UICollectionViewDataSource,
                     UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var delegate: TodaySessionViewDelegate?
    let data = DataManager.shared
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
        fatalError(Constants.requiredInit)
    }
    func setupSubviews() {
        collectionView.register(FocusAreaCollectionViewCell.self,
                             forCellWithReuseIdentifier: FocusAreaCollectionViewCell.identifier)
        [focusAreaViewTitle, collectionView].forEach { self.addSubview($0) }
        NSLayoutConstraint.activate([
            focusAreaViewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            focusAreaViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            focusAreaViewTitle.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: focusAreaViewTitle.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.getFocusAreaData().count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: FocusAreaCollectionViewCell.identifier,
                                                        for: indexPath) as?
                FocusAreaCollectionViewCell else { return UICollectionViewCell() }
        let workouts = data.getFocusAreaData()[indexPath.item]
        cell.focusAreaCell = workouts
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/2.3, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screen = FitConfigViewController.shared
        delegate?.didDisplayInputScreen(screen)
    }
}
