import UIKit

class ModalTopSwipeView: UIView {
    let data = DataManager.shared
    var cellImage: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.frame =  CGRect(x: 0, y: 0,
                             width: 300,
                             height: 200)
        view.dataSource = self
        view.delegate = self
        view.register(ModalTopSwipeCell.self,
                             forCellWithReuseIdentifier: ModalTopSwipeCell.identifier)
        return view
    }()
}
extension ModalTopSwipeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                                                        withReuseIdentifier: ModalTopSwipeCell.identifier,
                                                        for: indexPath) as? ModalTopSwipeCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(named: cellImage ?? "apple-img")
        cell.workoutModalImage.image = image 
        return cell
    }
}
extension ModalTopSwipeView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
}
