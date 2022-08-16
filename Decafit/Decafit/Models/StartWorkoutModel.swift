import Foundation
struct StartWorkoutModel {
    let exerciseName, duration, image: String
}
let startWorkoutData: [StartWorkoutModel] = {
    let workout1 = ["Stretch", "00:20", "back"]
    let workout2 = ["Running", "00:50", "back"]
    let workout3 = ["Jumping", "X10", "back"]
    let workout4 = ["Run", "01:00", "back"]
    let workout5 = ["Dancing", "X10", "back"]
    let workout6 = ["Push ups", "X10", "back"]
    let workout7 = ["Sky diving", "X10", "back"]
    let workout8 = ["Push downs", "X10", "back"]
    let workoutData = [workout1, workout2, workout3, workout4, workout5, workout6, workout7, workout8]
    
    var arr = [StartWorkoutModel]()
    for eachWorkout in workoutData {
        var res = StartWorkoutModel(exerciseName: "", duration: "", image: "")
        for _ in  0..<eachWorkout.count {
            res = StartWorkoutModel(exerciseName: eachWorkout[0], duration: eachWorkout[1], image: eachWorkout[2])
        }
        arr.append(res)
    }
    return arr
}()
