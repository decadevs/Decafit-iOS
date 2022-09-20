import UIKit

protocol ExerciseVCDelegate: AnyObject {
    func reloadData()
    func showCompletionTag()
}

protocol FocusAreaViewDelegate: AnyObject {
    func didDisplayFitConfigScreen(_ screen: FitConfigViewController, image: UIImage?, title: String, workoutId: String)
    func showDialog(workoutId: String)
}

protocol LogViewDelegate: AnyObject {
    func displayDetailView(screen: UIViewController)
}

protocol ExerciseCellDelegate: AnyObject {
    func gotoNextExercise(pauseTime: TimeInterval)
    func clickNavBackButton()
    func updatePauseTime(pauseTime: TimeInterval, resumeTapped: Bool)
    func startExercise()
}

protocol ProfileViewControllerDelegate: AnyObject {
    func didTapLogout()
}

protocol AuthManagerDelegate: AnyObject {
    func didShowAlert(title: String, message: String)
}

