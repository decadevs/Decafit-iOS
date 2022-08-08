//
//  TodaySessionModel.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
struct TodaySessionModel {
    let image, title, name, time, calorie: String
}
let todayData: [TodaySessionModel] = {
    let workoutData = [["weightlift", "Full Body", "Cersei Lanis", "24 min", "24 Kcal"],
                       ["weightlift", "Biceps", "Thorin Oakin", "30 min", "15 Kcal"]]
    var arr = [TodaySessionModel]()
    for eachWorkout in workoutData {
        var res = TodaySessionModel(image: "", title: "", name: "", time: "", calorie: "")
        for _ in  0..<eachWorkout.count {
            res = TodaySessionModel(image: eachWorkout[0], title: eachWorkout[1], name: eachWorkout[2], time: eachWorkout[3], calorie: eachWorkout[4])
        }
        arr.append(res)
    }
    return arr
}()
