import Foundation
import RealmSwift

final class StorageManager {
    static var shared = StorageManager()
    let realm = try! Realm()

    func saveExercise(_ object: DbExercise) {
        try! realm.write({
            realm.add(object, update: .modified)
        })
    }
    
    func updateExerciseRelationship(_ exercises: Results<DbExercise>, _ workout: DbWorkout) {
        for exercise in exercises {
           try! realm.write {
               workout.exerciseList.append(exercise)
           }
        }
    }
    
    func updateSingleExerciseRel(_ exercise: DbExercise, _ workout: DbWorkout) {
        try! realm.write {
            workout.exerciseList.append(exercise)
        }
    }

    func saveWorkout(_ objects: DbWorkout) {
        try! realm.write({
            realm.add(objects, update: .modified)
        })
    }
    
    func fetchAllExercises() -> Results<DbExercise> {
        return realm.objects(DbExercise.self)
        
    }
    
    func fetchAllWorkouts() -> Results<DbWorkout> {
        return realm.objects(DbWorkout.self)
    }
    
    func getWorkout(workoutId: String) -> DbWorkout {
        guard let workout = realm.object(ofType: DbWorkout.self, forPrimaryKey: workoutId) else { fatalError() }
        return workout
    }
    
    func getExercise(exerciseId: String) -> DbExercise {
        guard let exercise = realm.object(ofType: DbExercise.self, forPrimaryKey: exerciseId) else { fatalError() }
        return exercise
    }
    
    func deleteWorkout(workoutId: String) {
        try! realm.write({
            if let obj = realm.object(ofType: DbWorkout.self, forPrimaryKey: workoutId) {
                realm.delete(obj)
            }
            
        })
    }
    func deleteWorkoutExercises(workoutId: String) {
        try! realm.write({
            let workoutExercises = realm.objects(DbExercise.self).where({ $0.associatedWorkoutId == workoutId })
            realm.delete(workoutExercises)
        })
    }
    
    func deleteAll() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
}
