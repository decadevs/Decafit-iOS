import Foundation
import RealmSwift

class DbWorkout: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var workoutId: String = "wid"
    @Persisted var sets: Int = 0
    @Persisted var reps: Int = 0
    @Persisted var count: Int = 0
    @Persisted var time: String = "time"
    @Persisted var workoutDate: Date = Date()

    let exerciseList = List<DbExercise>()

    convenience init(workoutId: String, sets: Int, reps: Int, count: Int, time: String, workoutDate: Date) {
        self.init()
        self.workoutId = workoutId
        self.sets = sets
        self.reps = reps
        self.count = count
        self.time = time
        self.workoutDate = workoutDate
    }
}
class DbExercise: Object {
    @Persisted(primaryKey: true) var exerciseId: String = "exid"
    @Persisted var type: String = "type"
    @Persisted var paused: Bool = false
    @Persisted var completed: Bool = false
    @Persisted var limit: String = "limit"
    @Persisted var progress: Float = 0.0
    @Persisted var started: Bool = false
    @Persisted var dateExercised: Date = Date()
    @Persisted var associatedWorkoutId: String = "aswid"
    
    convenience init(exerciseId: String, type: String, paused: Bool, completed: Bool, limit: String, progress: Float, started: Bool, dateExercised: Date, associatedWorkoutId: String) {
        self.init()
        self.exerciseId = exerciseId
        self.type = type
        self.paused = paused
        self.completed = completed
        self.limit = limit
        self.progress = progress
        self.started = started
        self.dateExercised = dateExercised
        self.associatedWorkoutId = associatedWorkoutId
    }
    
    // Inverse to DbWorkout
    let dbworkout = LinkingObjects(fromType: DbWorkout.self, property: "exerciseList")

    var exerciseCompleted: Bool {
        return started == true && completed == true
    }
    var exerciseNotComplete: Bool {
        return started == true && completed == false
    }
    var exerciseNotStarted: Bool {
        return started == false && completed == false 
    }
}
