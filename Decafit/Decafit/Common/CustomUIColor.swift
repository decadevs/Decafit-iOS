//
//  CustomUIColor.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit
enum DecaColor {
    case gray
    case black
    case decafitOrange
    case decafitPurple
    case decafitLightGray
    case decafitDarkGray
    case decafitPalePurple
    case decafitLightGreen
    case decafitGreen
    case lightRed
    case red
    var color: UIColor {
        switch self {
        case .gray:
            return #colorLiteral(red: 0.7126122117, green: 0.74427706, blue: 0.7983196378, alpha: 1)
        case .black:
            return #colorLiteral(red: 0.1642587185, green: 0.1759757698, blue: 0.2050507069, alpha: 1)
        case .decafitOrange:
            return #colorLiteral(red: 0.9505439401, green: 0.394153595, blue: 0.1895760596, alpha: 1)
        case .decafitPurple:
            return #colorLiteral(red: 0.4031648636, green: 0.3810556829, blue: 0.658888042, alpha: 1)
        case .decafitLightGray:
            return #colorLiteral(red: 0.9684734941, green: 0.968393147, blue: 0.9848353267, alpha: 1)
        case .decafitDarkGray:
            return #colorLiteral(red: 0.516553998, green: 0.548253119, blue: 0.5981615782, alpha: 1)
        case .decafitPalePurple:
            return #colorLiteral(red: 0.7604640722, green: 0.7548263669, blue: 0.8625454903, alpha: 1)
        case .decafitLightGreen:
            return #colorLiteral(red: 0.9002782106, green: 0.9613595605, blue: 0.9450122714, alpha: 1)
        case .decafitGreen:
            return #colorLiteral(red: 0, green: 0.6074795723, blue: 0.4437177181, alpha: 1)
        case .lightRed:
            return #colorLiteral(red: 0.9974444509, green: 0.9414363503, blue: 0.9158548713, alpha: 1)
        case .red:
            return #colorLiteral(red: 0.9471881986, green: 0.3105561137, blue: 0, alpha: 1)
        }
    }
}
