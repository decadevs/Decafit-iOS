import Foundation
import RealmSwift

struct WorkoutNameAndImage {
    var name, image: String
}
class LogViewModel {
    let realmDb = StorageManager.shared
    let data = DataManager.shared
    var dbWorkout: DbWorkout?
    var dbExercise: DbExercise?
    var logs = [DbWorkout]()
    var workoutObjectArr = [WorkoutNameAndImage]()

    var allWorkoutReports: Results<DbWorkout> {
        return realmDb.fetchAllWorkouts()
    }
    
    func extractWorkoutName() {
        data.fetchWorkoutsCompletion = { [weak self] graphQLResult in
            print("graphQLResult", graphQLResult)
            if let workouts = graphQLResult.data?.workouts.compactMap({ $0 }) {
                
                for workout in workouts {
                    for log in self?.logs ?? [] {
                        if log.workoutId == workout.id {
                            let workoutObj = WorkoutNameAndImage(name: workout.title, image: workout.backgroundImage)
                            print("workoutObj", workoutObj)
                            self?.workoutObjectArr.append(workoutObj)
                            print("workoutObjectArr", self?.workoutObjectArr)
                        }
                        
                    }
                
                }
            }
        }
    }
    
    func getLogs() {
        for workoutReport in allWorkoutReports {
            logs.append(workoutReport)
        }
    }

    func updateValues() {
        data.fetchReportFromServerCompletion = { [weak self] result in
            print("Report Fetched from Server", result)
            guard let workouts = result.data?.report?.workouts, let userId = result.data?.report?.userId else { fatalError() }
            for workout in workouts {
                guard let workoutId = workout?.workoutId else { fatalError() }
                guard let workoutSet = workout?.workoutSet else { fatalError() }
                guard let workoutReps = workout?.workoutReps else { fatalError() }
                guard let workoutTime = workout?.workoutTime else { fatalError() }
                guard let workoutCount = workout?.workoutCount else { fatalError() }

                self?.dbWorkout = DbWorkout(workoutId: workoutId, sets: workoutSet, reps: workoutReps, count: workoutCount, time: workoutTime, workoutDate: Date())
                
                guard let exercises = workout?.exercises else { fatalError() }
                for exercise in exercises {
                    guard let exerciseId = exercise.excerciseId else { fatalError() }
                    guard let type = exercise.type else { fatalError() }
                    guard let paused = exercise.paused else { fatalError() }
                    guard let limit = exercise.limit else { fatalError() }
                    guard let completed = exercise.completed else { fatalError() }
                    guard let progress = exercise.progress else { fatalError() }
                    
                    self?.dbExercise = DbExercise(exerciseId: exerciseId, type: type.rawValue, paused: paused, completed: completed, limit: limit, progress: Float(progress), started: false, dateExercised: Date(), associatedWorkoutId: "")
                }
            }
            
        }
    }
}
