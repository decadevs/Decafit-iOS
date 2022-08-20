//
//  DataManager.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
final class DataManager {
    static let shared = DataManager()
    func getWorkoutData() -> [Exercise] {
        return exerciseData
    }
    func getFocusAreaData() -> [Workout] {
        return workoutData
    }
    func getTodayData() -> [TodaySessionModel] {
        return todayData
    }
}
