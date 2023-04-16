//
//  String+Extension.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 16/04/23.
//

import Foundation


extension String {
    func isCoppelEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z.%+-]+@(coppel.com)"
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
}
