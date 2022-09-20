//
//  ExerciseViewModel.swift
//  Decafit
//
//  Created by Decagon on 20/09/2022.
//

import Foundation
import RealmSwift

class ExerciseViewModel {
    
    var exerciseView = ExerciseView()
    let realm = try! Realm()
    let data = DataManager.shared
    let realmDb = StorageManager.shared
    let defaults = UserDefaults.standard
    let viewModel = ExerciseViewModel()
    
    var selectedWorkoutid: String?
    weak var delegate: ExerciseVCDelegate?
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()
    var exerciseRow = [WorkoutListQuery.Data.Workout.Exercise]()
    var filteredExerciseArr = [WorkoutListQuery.Data.Workout.Exercise]()
    var completedExerciseArr = [WorkoutListQuery.Data.Workout.Exercise]()

    var currentIndex: IndexPath = [0, 0]
    var lastIndex: IndexPath = [0, 0]
    var pauseTime: TimeInterval?
    var selectedWorkoutIndex: Int?
    var currentExerciseId: String?
        
//    typealias WorkoutData = GetWorkoutReportQuery.Data.ReportWorkout.Workout
//    var workoutExercisesList = [WorkoutData.Exercise]()
//    var savedExercisesList = [ReportExcerciseProgressInput]()
    
    var notifyExerciseCompletion: (() -> Void)?
    
    var currentWorkoutReport: DbWorkout {
        guard let currentWorkoutId = defaults.string(forKey: UserDefaultKeys.workoutID) else { fatalError() }
        return realmDb.getWorkout(workoutId: currentWorkoutId)
    }
    var nextExerciseBtnTitle: String {
        var title = ""
        print("Double().repsTracker", Double().repsTracker)
        print("Int repstracker", Int().repsTracker)
        if Double().repsTracker > 1 {
            title = Constants.repeatExercise
        } else {
            title = Constants.nextExercise
        }
        return title
    }
    
    var repsProgressTagTitle: String {
        let title = "\(Int().repsTracker) Of \(currentWorkoutReport.reps) Reps"
        return title
    }
    
    func getExerciseReports() {
        
    }
    
    func filteredExercisesReport() {
        let exercisesReport = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == selectedWorkoutid ?? "0" })
        if exercisesReport.count > 0 {
            for each in exercisesReport {
                if each.exerciseCompleted == true {
                    let completedExercises = exercises.filter({ $0.id == each.exerciseId })
                    completedExerciseArr.append(contentsOf: completedExercises)
                } else {

                    let filteredExercises = exercises.filter({ $0.id == each.exerciseId })
                    filteredExerciseArr.append(contentsOf: filteredExercises)
                }
            }
            exerciseRow = filteredExerciseArr
        } else {
            exerciseRow = exercises
        }
        
    }
    
}
