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
    case ubuntuLightItalic = "Ubuntu-LightItalic"
    case ubuntuRegular = "Ubuntu-Regular"
    case ubuntuBold = "Ubuntu-Bold"
    case ubuntuMediumItalic = "Ubuntu-MediumItalic"
    case ubuntuBoldItalic = "Ubuntu-BoldItalic"
    case ubuntuItalic = "Ubuntu-Italic"
    case ubuntuLight = "Ubuntu-Light"
    case poppinsExtraLight = "Poppins-ExtraLight"
    case poppinsThinItalic = "Poppins-ThinItalic"
    case poppinsExtraLightItalic = "Poppins-ExtraLightItalic"
    case poppinsBoldItalic = "Poppins-BoldItalic"
    case poppinsLight = "Poppins-Light"
    case poppinsMedium = "Poppins-Medium"
    case poppinsSemiBoldItalic = "Poppins-SemiBoldItalic"
    case poppinsExtraBoldItalic = "Poppins-ExtraBoldItalic"
    case poppinsExtraBold = "Poppins-ExtraBold"
    case poppinsBlackItalic = "Poppins-BlackItalic"
    case poppinsRegular = "Poppins-Regular"
    case poppinsLightItalic = "Poppins-LightItalic"
    case poppinsBold = "Poppins-Bold"
    case poppinsBlack = "Poppins-Black"
    case poppinsThin = "Poppins-Thin"
    case poppinsSemiBold = "Poppins-SemiBold"
    case poppinsItalic = "Poppins-Italic"
    case poppinsMediumItalic = "Poppins-MediumItalic"
}

func decaFont(size: CGFloat, font: CustomFontFamily) -> UIFont {
    guard let customFont = UIFont(name: font.rawValue, size: size) else {
    return UIFont.systemFont(ofSize: size)
  }
  return customFont
}
