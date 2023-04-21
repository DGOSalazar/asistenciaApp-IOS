//
//  Font+Extension.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation
import UIKit


public extension UIFont {
    private static var areFontsRegistered: Bool = false
    private static var responsiveModifier: CGFloat = (DeviceSize.size == .large ? 0.0 : (DeviceSize.size == .medium ? 0.5 : 1.0))
    
    private static func registerFontsIfNeeded() {
        guard !self.areFontsRegistered else {
            return
        }
        
        guard let fonts = (Bundle.init(for: AppDelegate.self).urls(forResourcesWithExtension: "ttf", subdirectory: nil) as? [CFURL]), !fonts.isEmpty else {
            return
        }

        for font in fonts {
            CTFontManagerRegisterFontsForURL(font, .process, nil)
        }
        
        self.areFontsRegistered = true
    }
    
    static func robotoRegular(ofSize: CGFloat) -> UIFont {
        self.registerFontsIfNeeded()
        return UIFont(name: "Roboto-Regular",
                      size: ofSize - self.responsiveModifier) ?? UIFont.systemFont(ofSize: ofSize - self.responsiveModifier,
                                                                                   weight: .regular)
    }
    static func robotoItalic(ofSize: CGFloat) -> UIFont {
        self.registerFontsIfNeeded()
        return UIFont(name: "Roboto-Italic",
                      size: ofSize - self.responsiveModifier) ?? UIFont.italicSystemFont(ofSize: ofSize - self.responsiveModifier)
    }
    static func robotoMedium(ofSize: CGFloat) -> UIFont {
        self.registerFontsIfNeeded()
        return UIFont(name: "Roboto-Medium",
                      size: ofSize - self.responsiveModifier) ?? UIFont.systemFont(ofSize: ofSize - self.responsiveModifier,
                                                                                   weight: .medium)
    }
    static func robotoBold(ofSize: CGFloat) -> UIFont {
        self.registerFontsIfNeeded()
        return UIFont(name: "Roboto-Bold",
                      size: ofSize - self.responsiveModifier) ?? UIFont.systemFont(ofSize: ofSize - self.responsiveModifier,
                                                                                   weight: .bold)
    }
}
