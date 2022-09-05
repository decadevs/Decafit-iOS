//
//  Defaults.swift
//  Decafit
//
//  Created by Decagon on 25/08/2022.
//
import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case workoutReport
    }
    
    var workoutReport: SavedWorkoutReport? {
        get {
            if let data = object(forKey: UserDefaultKeys.workoutReport.rawValue) as? Data {
                let report = try? JSONDecoder().decode(SavedWorkoutReport.self, from: data)
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
