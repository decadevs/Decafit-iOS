//
//  FocusAreaModel.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//
import Foundation

struct Workout: Codable {
    let data: DataClass
}
struct DataClass: Codable {
    let workouts: [WorkoutElement]
}
struct WorkoutElement: Codable {
    let id: String
    var title: String
    let backgroundImage: String
    let sets, reps: Int
    let createdAt: String
    let exercises: [Exercise]
}
struct Exercise: Codable {
    let id, title, exerciseDescription: String
    let image: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case id, title
        case exerciseDescription = "description"
        case image, type
    }
}

enum TypeEnum: String, Codable {
    case count = "count"
    case time = "time"
}
