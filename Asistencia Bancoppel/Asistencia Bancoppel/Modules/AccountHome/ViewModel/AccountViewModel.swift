//
//  AccountViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 20/04/23.
//

import Foundation

class AccountViewModel {
    var accountObaservable = CustomObservable<(AccountModel?, String?)>()
    var dayAttendance = CustomObservable<([DayAttendanceModel]?, String?)>()
    
    func getAccountData(email: String) {
        FirebaseManager.shared.getData(collection: GlobalConstants.Firebase.Collections.usersCollection,
                                       document: email,
                                       dataType: AccountModel.self) { [weak self] data in
            self?.accountObaservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.accountObaservable.value = (nil, error)
        }
    }
    
    
    func getDayAttendance() {
        FirebaseManager.shared.getDocuments(collection: GlobalConstants.Firebase.Collections.dayCollection,
                                            dataType: DayAttendanceModel.self) { [weak self] data in
            self?.dayAttendance.value = (data, nil)
        } failure: { [weak self] error in
            self?.dayAttendance.value = (nil, error)
        }
    }
}
