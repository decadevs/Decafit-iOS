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
    let first = TodaySessionModel(image: "weightlift", title: "Full Body",
                      name: "Cersei Lan", time: "24 min", calorie: "24 Kcal")
    let second = TodaySessionModel(image: "fitness-img", title: "Biceps",
                      name: "Karl Drogo", time: "30 min", calorie: "15 Kcal")
    return [first, second]
}()
