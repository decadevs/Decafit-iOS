//
//  SavedReport.swift
//  Decafit
//
//  Created by Decagon on 01/09/2022.
//

import Foundation

struct SavedWorkoutReport: Codable {
    var workout: [SavedWorkout]
}
struct SavedWorkout: Codable {
    var workoutId: String?
    var exerciseArr: [ExerciseReport]? = []
}
struct ExerciseReport: Codable {
    var excerciseId: String?
    var type: String
    var paused, completed: Bool?
    var limit: String
    var progress: Float 
    var started: Bool? = false 
}
