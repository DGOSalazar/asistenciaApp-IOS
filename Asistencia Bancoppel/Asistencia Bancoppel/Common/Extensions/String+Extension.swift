//
//  String+Extension.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 16/04/23.
//

import Foundation


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
}
