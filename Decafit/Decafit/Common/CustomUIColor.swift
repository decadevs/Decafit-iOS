//
//  CustomUIColor.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit
enum DecaColor {
    case decafitGray
    case decafitBlack
    case decafitOrange
    case decafitPurple
    case decafitLightGray
    case decafitDarkGray
    case decafitPalePurple
    var color: UIColor {
        switch self {
        case .decafitGray:
            return #colorLiteral(red: 0.7126122117, green: 0.74427706, blue: 0.7983196378, alpha: 1)
        case .decafitBlack:
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
        }
    }
}
