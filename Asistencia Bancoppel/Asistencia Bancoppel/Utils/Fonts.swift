//
//  Fonts.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit

enum Fonts: String {
    case RobotoRegular = "RobotoRegular"
    case RobotoMedium = "RobotoMedium"
    case RobotoBold = "RobotoBold"
    case Roboto = "Roboto"
    case RobotoItalic = "RobotoItalic"

    func of(size: CGFloat) -> UIFont {
        let font = UIFont(name: rawValue, size: size - 1) ?? UIFont.systemFont(ofSize: size - 1)
        return font
    }
}
