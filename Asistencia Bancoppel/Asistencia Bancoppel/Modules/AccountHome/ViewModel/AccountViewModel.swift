//
//  AccountViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 20/04/23.
//

import Foundation
import UIKit

class AccountViewModel {
    var dayAttendanceObservable = CustomObservable<([DayAttendanceModel]?, String?)>()
    var usersObservable = CustomObservable<([UserAttendanceDataModel]?, String?)>()
    
    func getDayAttendance() {
        FirebaseManager.shared.getDocuments(collection: GlobalConstants.Firebase.Collections.dayCollection,
                                            dataType: DayAttendanceModel.self) { [weak self] data in
            self?.dayAttendanceObservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.dayAttendanceObservable.value = (nil, error)
        }
    }
    
    func getUsersData() {
        FirebaseManager.shared.getDocuments(collection: GlobalConstants.Firebase.Collections.usersCollection,
                                            dataType: AccountModel.self) { [weak self] data in
            
            let auxUsers: [UserAttendanceDataModel] = data.compactMap { user in
                UserAttendanceDataModel(name: user.name ?? "",
                                        fullname: "\(user.name ?? "") \(user.lastName1 ?? "") \(user.lastName2 ?? "")",
                                        email: user.email ?? "",
                                        position: UserPositionEnum.getPosition(str: user.position ?? ""),
                                        profilePhotoURL: user.profilePhoto ?? "",
                                        profilePhoto: nil)
            }
            
            self?.usersObservable.value = (auxUsers, nil)
        } failure: { [weak self] error in
            self?.usersObservable.value = (nil, error)
        }
    }
}
