//
//  FocusAreaModel.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
struct FocusAreaModel {
    let image, bodyPart, duration: String
}
let focusData: [FocusAreaModel] = {
    let workout1 = ["back", "Back", "20 days"]
    let workout2 = ["back", "Abs", "30 days"]
    let workout3 = ["back", "Thigh", "10 days"]
    let workout4 = ["back", "Back", "20 days"]
    let workout5 = ["back", "Abs", "30 days"]
    let workout6 = ["back", "Thigh", "10 days"]
    let workoutData = [workout1, workout2, workout3, workout4, workout5, workout6]
    
    var arr = [FocusAreaModel]()
    for eachWorkout in workoutData {
        var res = FocusAreaModel(image: "", bodyPart: "", duration: "")
        for _ in  0..<eachWorkout.count {
            res = FocusAreaModel(image: eachWorkout[0], bodyPart: eachWorkout[1], duration: eachWorkout[2])
        }
        arr.append(res)
    }
    return arr
}()
