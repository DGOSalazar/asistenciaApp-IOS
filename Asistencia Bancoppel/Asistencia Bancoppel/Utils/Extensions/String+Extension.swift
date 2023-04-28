//
//  String+Extension.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 16/04/23.
//

import Foundation
import UIKit


extension String {
    func isCoppelEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z.%+_-]+@(coppel.com)"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isPhoneNumber() -> Bool {
        if self.count == 10, let _ = Int(self) {
            return true
        } else {
            return false
        }
    }
    
    func removeAccentMarks() -> String {
        let cleanLowercased = (self.replacingOccurrences(of: "á", with: "a").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "í", with: "i").replacingOccurrences(of: "ó", with: "o").replacingOccurrences(of: "ú", with: "u"))
        let cleanUppercased = cleanLowercased.replacingOccurrences(of: "Á", with: "A").replacingOccurrences(of: "É", with: "E").replacingOccurrences(of: "Í", with: "I").replacingOccurrences(of: "Ó", with: "O").replacingOccurrences(of: "Ú", with: "U")
        return cleanUppercased
    }
    
    
    func isAlphanumeric() -> Bool {
        let regex = "[A-Za-z0-9 ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isSpaAlphanumeric() -> Bool {
        let regex = "[A-Za-z0-9 ñÑáéíóúÁÉÍÓÚüÜ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isAlphabetic() -> Bool {
        let regex = "[A-Za-z ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isSpaAlphabetic() -> Bool {
        let regex = "[A-Za-z ñÑáéíóúÁÉÍÓÚüÜ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isNumeric() -> Bool {
        let regex = "[0-9 ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    func isEmailAllowedChar() -> Bool {
        let regex = "[A-Za-z0-9.%+_-]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func attributed(color: UIColor,
                    font: UIFont,
                    lineBreakMode: NSLineBreakMode = .byWordWrapping,
                    textAlignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = lineBreakMode
        
        let attributes = [NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font : font,
                          NSAttributedString.Key.paragraphStyle : style]
        
        let attributed = NSMutableAttributedString(string: self,
                                                   attributes: attributes)
        
        return attributed
    }
    
    
    func toDate(_ dateStringFormat: String = "dd-MM-yy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.dateFormat = dateStringFormat
        return dateFormatter.date(from: self)
    }
}
