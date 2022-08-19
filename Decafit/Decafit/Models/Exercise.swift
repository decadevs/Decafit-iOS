import Foundation
struct Exercise: Codable {
    let exerciseName, duration, image: String
    // id: ID,
    // title, description, pauseTime: String
    // paused: Bool
    // completed: Bool = false
    static var getAllExercises: [Exercise] {
        let defaultExercise = Exercise(exerciseName: "", duration: "", image: "")
          if let exercises = UserDefaults.standard.value(forKey: "exercises") as? Data {
             let decoder = JSONDecoder()
             if let exercisesDecoded = try? decoder.decode(Array.self, from: exercises) as [Exercise] {
                return exercisesDecoded
             } else {
                return [defaultExercise]
             }
          } else {
             return [defaultExercise]
          }
    }
     static func saveAllExercises(allExercises: [Exercise]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allExercises){
             UserDefaults.standard.set(encoded, forKey: "exercises")
          }
     }
}
let exerciseData: [Exercise] = {
    let workout1 = ["Stretch", "00:20", "back"]
    let workout2 = ["Running", "00:50", "back"]
    let workout3 = ["Jumping", "X10", "back"]
    let workout4 = ["Run", "01:00", "back"]
    let workout5 = ["Dancing", "X10", "back"]
    let workout6 = ["Push ups", "X10", "back"]
    let workout7 = ["Sky diving", "X10", "back"]
    let workout8 = ["Push downs", "X10", "back"]
    let data = [workout1, workout2, workout3, workout4, workout5, workout6, workout7, workout8]
    
    var arr = [Exercise]()
    for exercise in data {
        var res = Exercise(exerciseName: "", duration: "", image: "")
        for _ in  0..<exercise.count {
            res = Exercise(exerciseName: exercise[0], duration: exercise[1], image: exercise[2])
        }
        arr.append(res)
    }
    return arr
}()
