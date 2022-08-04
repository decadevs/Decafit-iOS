//
//  DataManager.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
final class DataManager {
    static let shared = DataManager()
    func getWorkoutData() -> [StartWorkoutModel] {
        return startWorkoutData
    }
    func getFocusAreaData() -> [FocusAreaModel] {
        return focusData
    }
    func getTodayData() -> [TodaySessionModel] {
        return todayData
    }
}
