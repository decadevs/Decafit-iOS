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
    let first = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let second = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let third = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let fourth = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let fifth = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let sixth = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let seventh = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    let eight = StartWorkoutModel(exerciseName: "Push ups", duration: "X10", image: "window")
    return [first, second, third, fourth, fifth, sixth, seventh, eight]
}()
