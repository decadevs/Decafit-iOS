//
//  FocusAreaModel.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation
struct FocusAreaModel {
    let image, bodyPart, duration: String
}
let focusData: [FocusAreaModel] = {
    let first = FocusAreaModel(image: "back", bodyPart: "Back", duration: "20 days")
    let second = FocusAreaModel(image: "meditate", bodyPart: "Abs", duration: "30 days")
    let third = FocusAreaModel(image: "meditate", bodyPart: "Thigh", duration: "10 days")
    let fourth = FocusAreaModel(image: "stretch", bodyPart: "Abs", duration: "30 days")
    let fifth = FocusAreaModel(image: "stretch", bodyPart: "Thigh", duration: "10 days")
    let sixth = FocusAreaModel(image: "back", bodyPart: "Butt", duration: "30 days")
    return [first, second, third, fourth, fifth, sixth]
}()
