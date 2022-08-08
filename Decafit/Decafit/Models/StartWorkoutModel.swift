//
//  StartWorkoutModel.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
struct StartWorkoutModel {
    let exerciseName, duration, image: String
}
let startWorkoutData: [StartWorkoutModel] = {
    let workout1 = ["Jumping jacks", "00:20", "back"]
    let workout2 = ["Push ups", "X10", "back"]
    let workout3 = ["Push ups", "X10", "back"]
    let workout4 = ["Push ups", "X10", "back"]
    let workout5 = ["Push ups", "X10", "back"]
    let workout6 = ["Push ups", "X10", "back"]
    let workout7 = ["Push ups", "X10", "back"]
    let workout8 = ["Push ups", "X10", "back"]
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
