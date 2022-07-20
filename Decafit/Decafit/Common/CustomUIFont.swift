//
//  CustomUIFont.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import Foundation
import UIKit

enum CustomFontFamily: String {
    case ubuntuMedium = "Ubuntu-Medium"
    case poppinsMedium = "Poppins-Medium"
    case poppinsRegular = "Poppins-Regular"
}

func customFont(size: CGFloat, font: CustomFontFamily) -> UIFont {
    guard let customFont = UIFont(name: font.rawValue, size: size) else {
    return UIFont.systemFont(ofSize: size)
  }
  return customFont
}
