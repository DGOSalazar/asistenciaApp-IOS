//
//  LoginViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Joel Ramirez on 18/04/23.
//

import Foundation

class LoginViewModel {
    
    var loginObservable = CustomObservable<Bool>()
    
     func makeLogin (email: String, credential: String) {
        FirebaseManager.shared.signIn(email: email, credential: credential) {
            self.loginObservable.value = true
            print()
        } failure: { error in
            print("ERROR LOGIN: \(error.description)")
            self.loginObservable.value = false
        }

    }
}
