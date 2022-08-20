import UIKit
protocol ExerciseVCDelegate: AnyObject {
    func reload()
}
class ExerciseViewController: UIViewController {
    var exerciseView = ExerciseView()
    let data = DataManager.shared
    weak var exerciseDelegate: ExerciseVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(ExerciseCell.self,
                             forCellWithReuseIdentifier: ExerciseCell.identifier)
        return view
    }()
}
extension ExerciseViewController: UIGestureRecognizerDelegate, ExerciseCellDelegate {
    func updatePauseTime(pauseTime: TimeInterval) {
        // Exercise.getAllExercises[indexPath.row].pauseTime = pauseTime
        // Exercise.saveAllExercises(allExercises: [])
        
    }
    
    func gotoNextExercise() {
        // If pausetime < endtime, isCompleted = false, else true
        // endtime is the time set in fitconfig
        // save the result
        exerciseDelegate?.reload()
        scrollViewWillEndDragging(collectionView, withVelocity: collectionView.contentOffset, targetContentOffset: &collectionView.contentOffset)
    }
    
    func clickNavBackButton() {
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
        cell.exerciseCellDelegate = self
        let stepcell = cell.exerciseView
        if workout.exerciseName == "Running" {
            stepcell.progressCircle.isHidden = true
            stepcell.stepsTakenView.isHidden = false
            stepcell.timerLabel.isHidden = true
            stepcell.pauseResumeButton.tag = Tags.stepcell
            stepcell.displaySteps()
        } else {
            stepcell.progressCircle.isHidden = false
            stepcell.stepsTakenView.isHidden = true
            stepcell.timerLabel.isHidden = false
        }
        return cell
    }
}
extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var factor: CGFloat = 0.5
        if velocity.x < 0 {
            factor = -factor
        }
        let pageWidth: Float = Float(self.view.bounds.width)
        let minSpace: Float = 10.0
        var cellToSwipe: Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5) + Double(factor)
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= Double(data.getWorkoutData().count) {
            cellToSwipe = Double(data.getWorkoutData().count) - Double(1)
        }
        let indexPath: IndexPath = IndexPath(row: Int(cellToSwipe), section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
