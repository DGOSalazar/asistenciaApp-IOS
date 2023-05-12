//
//  ProfileViewModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation
import UIKit


class ProfileViewModel {
    var accountGetMoreDataDataObservable = CustomObservable<(AccountMoreDataModel?, String?)>()
    var accountUpdateProfilePhoto = CustomObservable<Bool>()
    var accountSaveMoreDataDataObservable = CustomObservable<Bool>()
    var errorObservable = CustomObservable<String>()
    
    
    func getAccountMoreData(email: String) {
        FirebaseManager.shared.getData(collection: GlobalConstants.Firebase.Collections.usersCollectionMoreData,
                                       document: email,
                                       dataType: AccountMoreDataModel.self) { [weak self] data in
            self?.accountGetMoreDataDataObservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.accountGetMoreDataDataObservable.value = (nil, error)
        }
    }
    
    
    func uploadPhoto(email: String, photo: UIImage) {
        FirebaseManager.shared.uploadPhoto(photo: photo, email: email) { [weak self] url in
            self?.updateAccountProfilePhotoURL(email: email, data: AccountProfilePhotoModel(profilePhoto: url))
        } failure: { [weak self] error in
            self?.errorObservable.value = error
        }
    }
    
    
    private func updateAccountProfilePhotoURL(email: String, data: AccountProfilePhotoModel) {
        FirebaseManager.shared.updateData(collection: GlobalConstants.Firebase.Collections.usersCollection,
                                          document: email,
                                          data: data) { [weak self] in
            self?.accountUpdateProfilePhoto.value = true
        } failure: { [weak self] error in
            self?.errorObservable.value = error
        }
    }
    
    func saveAccountMoreData(data: AccountMoreDataModel) {
        guard let nonNilEmail = data.email, !nonNilEmail.isEmpty else {
            errorObservable.value = "Email is not valid or is empty"
            return
        }
        
        FirebaseManager.shared.saveData(collection: GlobalConstants.Firebase.Collections.usersCollectionMoreData,
                                        document: nonNilEmail,
                                        data: data) { [weak self] in
            self?.accountSaveMoreDataDataObservable.value = true
        } failure: { [weak self] error in
            self?.errorObservable.value = error
        }
    }
}
