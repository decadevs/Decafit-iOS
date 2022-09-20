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
        guard let currentWorkoutId = defaults.string(forKey: UserDefaultKeys.workoutID) else { fatalError() }
        return realmDb.getWorkout(workoutId: currentWorkoutId)
    }
    
    var currentExerciseReport: DbExercise {
        guard let currentExerciseID = currentExerciseId else { fatalError() }
        return realmDb.getExercise(exerciseId: currentExerciseID)
    }
    
    var isWorkoutCompleted: Bool {
        guard let currentWorkoutId = defaults.string(forKey: UserDefaultKeys.workoutID) else { fatalError() }
        let workouts = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == currentWorkoutId })
        var completedArr = [DbExercise]()
        for workout in workouts where workout.exerciseCompleted == true  {
            completedArr.append(workout)
        }
        return completedArr.count == workouts.count
    }
    // MARK: - Workout Button Title
    var workoutBtnTitle: String {
        var title = ""
        let assocExercises = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == selectedId ?? "0" })
        assocExercises.forEach { exercise in
            if exercise.exerciseNotStarted == true {
                title = Constants.startWorkout
            } else if exercise.exerciseNotComplete == true {
                title = Constants.continueWorkout
            } else {
                title = Constants.workoutComplete
            }
        }
        return title
    }
    
}
