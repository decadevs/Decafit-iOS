//
//  Defaults.swift
//  Decafit
//
//  Created by Decagon on 25/08/2022.
//
import Foundation

struct ReportCreate: Codable {
    var userID: String
    var workouts: [Workout1]
}
struct Workout1: Codable {
    var workoutId: String? = ""
    var workoutTime: String? = ""
    var workoutReps: Int? = 0
    var workoutSet: Int? = 0
    var workoutCount: Int? = 0
    var exercises: [ReportExcerciseProgress]? = []
    
}
struct ReportExcerciseProgress: Codable {
    var excerciseId, pausedTime: String?
    var type: EnumType1?
    var paused, completed: Bool?
}
enum EnumType1: String, Codable {
    case count = "count"
    case time = "time"
}
extension UserDefaults {
    private enum UserDefaultKeys: String {
        case workoutReport
    }
    
    var workoutReport: ReportCreate? {
        get {
            if let data = object(forKey: UserDefaultKeys.workoutReport.rawValue) as? Data {
                let report = try? JSONDecoder().decode(ReportCreate.self, from: data)
                return report
            }
            return nil
        }
        set {
            if newValue == nil {
                removeObject(forKey: UserDefaultKeys.workoutReport.rawValue)
            } else {
                let data = try? JSONEncoder().encode(newValue)
                setValue(data, forKey: UserDefaultKeys.workoutReport.rawValue)
            }
        }
    }
}
