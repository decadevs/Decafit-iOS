//
//  FocusAreaModel.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
struct Workout: Codable {
    let backgroundImage, title: String
    var duration: String = "01:00"
//    var sets, reps, count, time: Int
    // id: ID, title: String, backgroundImage, createdAt: String
    //  exercises: [Excercise] 
    static var getAllWorkouts: [Workout] {
        let defaultWorkout = Workout(backgroundImage: "", title: "", duration: "")
          if let workouts = UserDefaults.standard.value(forKey: "workouts") as? Data {
             let decoder = JSONDecoder()
             if let workoutsDecoded = try? decoder.decode(Array.self, from: workouts) as [Workout] {
                return workoutsDecoded
             } else {
                return [defaultWorkout]
             }
          } else {
             return [defaultWorkout]
          }
    }

    static func saveAllWorkouts(allWorkouts: [Workout]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allWorkouts) {
             UserDefaults.standard.set(encoded, forKey: "workouts")
          }
     }
    
}
let workoutData: [Workout] = {
    let workout1 = ["back", "Back", "20 days"]
    let workout2 = ["back", "Abs", "30 days"]
    let workout3 = ["back", "Thigh", "10 days"]
    let workout4 = ["back", "Back", "20 days"]
    let workout5 = ["back", "Abs", "30 days"]
    let workout6 = ["back", "Thigh", "10 days"]
    let workoutData = [workout1, workout2, workout3, workout4, workout5, workout6]
    
    var arr = [Workout]()
    for eachWorkout in workoutData {
        var res = Workout(backgroundImage: "", title: "", duration: "")
        for _ in  0..<eachWorkout.count {
            res = Workout(backgroundImage: eachWorkout[0], title: eachWorkout[1], duration: eachWorkout[2])
        }
        arr.append(res)
    }
    return arr
}()
