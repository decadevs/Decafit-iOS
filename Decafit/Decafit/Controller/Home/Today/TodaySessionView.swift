//
//  TodaySession.swift
//  Decafit
//
//  Created by Decagon on 28/07/2022.
//
import UIKit
protocol TodaySessionViewDelegate: AnyObject {
    func didDisplayInputScreen(_ screen: FitConfigViewController)
}
struct TodaySessionModel {
let image, title, name, time, calorie: String
}
class TodaySessionView: UIView {
    weak var delegate: TodaySessionViewDelegate?
    let data: [TodaySessionModel] = {
        let first = TodaySessionModel(image: "weightlift", title: "Full Body",
                          name: "Cersei Lan", time: "24 min", calorie: "24 Kcal")
        let second = TodaySessionModel(image: "fitness-img", title: "Biceps",
                          name: "Karl Drogo", time: "30 min", calorie: "15 Kcal")
        return [first, second]
    }()
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
        return CGSize(width: self.frame.size.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screen = FitConfigViewController.shared
        (delegate?.didDisplayInputScreen(screen))
    }
}
