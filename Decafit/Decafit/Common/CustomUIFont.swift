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
    case ubuntuBold = "Ubuntu-Bold"
    case poppinsMedium = "Poppins-Medium"
    case poppinsRegular = "Poppins-Regular"
    case poppinsBold = "Poppins-Bold"
    case poppinsLight = "Poppins-Light"
}

func decaFont(size: CGFloat, font: CustomFontFamily) -> UIFont {
    guard let customFont = UIFont(name: font.rawValue, size: size) else {
    return UIFont.systemFont(ofSize: size)
  }
  return customFont
}
