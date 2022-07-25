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
        }
    }
}
