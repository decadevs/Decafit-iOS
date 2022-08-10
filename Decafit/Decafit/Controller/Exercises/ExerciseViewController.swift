import UIKit
class ExerciseViewController: UIViewController, ExerciseCellDelegate {
    func refCellElements(exerciseView: ExerciseView) {
        exerciseView.timerViewBackButton.addTarget(
            self, action: #selector(clickNavBackButton), for: .touchUpInside)
        exerciseView.nextWorkoutButton.addTarget(
            self, action: #selector(nextPageButtonClicked), for: .touchUpInside)
    }
    let data = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        let ecell = ExerciseCell()
        ecell.delegate = self
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.dataSource = self
        view.delegate = self
        view.register(ExerciseCell.self,
                             forCellWithReuseIdentifier: ExerciseCell.identifier)
        return view
    }()
    @objc func nextPageButtonClicked() {
        print("========= next page button pressed ===========")
        guard let indexPath = collectionView.indexPathsForVisibleItems.first.flatMap({
            IndexPath(item: $0.row + 1, section: $0.section)
        }), collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
extension ExerciseViewController: UIGestureRecognizerDelegate {
    @objc func clickNavBackButton() {
        print("========= nav bar back button pressed ===========")
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.popViewController(animated: true)
    }
}
extension ExerciseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.getWorkoutData().count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExerciseCell.identifier,
                for: indexPath) as? ExerciseCell else { return UICollectionViewCell() }
        let workout = data.getWorkoutData()[indexPath.row]
        cell.configure(with: workout)
        cell.delegate = self
        return cell
    }
}
extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height*0.95)
    }
}
