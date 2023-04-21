//
//  AccountViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 20/04/23.
//

import Foundation

class AccountViewModel {
    var accountObaservable = CustomObservable<(AccountModel?, String?)>()
    
    func registerAccount(email: String) {
        FirebaseManager.shared.getData(collection: GlobalConstants.Firebase.Collections.usersCollection,
                                       document: email,
                                       dataType: AccountModel.self) { [weak self] data in
            self?.accountObaservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.accountObaservable.value = (nil, error)
        }
    }
}
