import Foundation
import RealmSwift
class WorkoutViewModel {
    
    let data = DataManager.shared
    var detailsView = ModalViewController()
    let defaults = UserDefaults.standard
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()
    var exercises2 = [WorkoutListQuery.Data.Workout.Exercise]()

    var selectedId: String?
    var currentIndex: IndexPath = [0, 0]
    var completion: ((Bool) -> Void)?
    var currentExerciseId: String?
    let realmDb = StorageManager.shared
    let home = HomeViewController.getHomeView()
    let realm = try! Realm()
    let arr: List<DbExercise> = List<DbExercise>()
    
    var currentWorkoutReport: DbWorkout {
        guard let selectedWorkoutId = selectedId else { fatalError() }
        return realmDb.getWorkout(workoutId: selectedWorkoutId)
    }
    
    var currentExerciseReport: DbExercise {
        guard let currentExerciseID = currentExerciseId else { fatalError() }
        return realmDb.getExercise(exerciseId: currentExerciseID)
    }
    
//    for each in realmDb.fetchAllExercises() {
//        print("Exercise in realm", each)
//    }
//    for each in realmDb.fetchAllWorkouts() {
//        print("Workout in realm", each)
//    }
    
//    
//    func getExercises() {
//        data.getExerciseList(workoutId: selectedId ?? "")
//        data.exerciseCompletion = { [weak self] result in
//            DispatchQueue.main.async {
//                self?.exercises = result
//                self?.tableView.reloadData()
//                self?.topView.titleLabel.text = "\(self?.exercises.count ?? 0) Exercises"
//            }
//        }
//    }
    
}
