//
//  Fonts.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit

enum Fonts: String {
    case SFProBook = "SFProText-Regular"
    case RobotoRegular = "RobotoRegular"
    case SFProHeavy = "SFProText-Heavy"
    case SFProMedium = "SFProText-Medium"
    case RobotoMedium = "RobotoMedium"
    case SFProBold = "SFProText-Bold"
    case RobotoBold = "RobotoBold"
    case Roboto = "Roboto"
    case RobotoItalic = "RobotoItalic"

    func of(size: CGFloat) -> UIFont {
        let font = UIFont(name: rawValue, size: size - 1) ?? UIFont.systemFont(ofSize: size - 1)
        return font
    }
}
