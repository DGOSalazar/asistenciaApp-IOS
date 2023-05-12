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
    
    var getProjectsObservable = CustomObservable<(ProfileProjectsModel?, String?)>()
    var getCertificationsObservable = CustomObservable<(ProfileCertificationsModel?, String?)>()
    
    var uploadProjectObservable = CustomObservable<Bool>()
    var uploadCertificateObservable = CustomObservable<Bool>()
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
    
    
    func getProjects(email: String) {
        FirebaseManager.shared.getData(collection: GlobalConstants.Firebase.Collections.userProjectCollection,
                                       document: email,
                                       dataType: ProfileProjectsModel.self) { [weak self] data in
            self?.getProjectsObservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.getProjectsObservable.value = (nil, error)
        }
    }
    
    func uploadProject(email: String, data: ProfileProjectsModel.Project) {
        let auxData = ProfileProjectsModel(email: email,
                                           projectInfo: [data])
        

        FirebaseManager.shared.updateData(collection: GlobalConstants.Firebase.Collections.userProjectCollection,
                                          document: email,
                                          data: auxData,
                                          createIfItDoesNotExist: true) { [weak self] in
            self?.uploadProjectObservable.value = true
        } failure: { [weak self] error in
            self?.errorObservable.value = error
        }
    }
    
    
    func getCertifications(email: String) {
        FirebaseManager.shared.getData(collection: GlobalConstants.Firebase.Collections.userCertificationsCollection,
                                       document: email,
                                       dataType: ProfileCertificationsModel.self) { [weak self] data in
            self?.getCertificationsObservable.value = (data, nil)
        } failure: { [weak self] error in
            self?.getCertificationsObservable.value = (nil, error)
        }
    }
    
    
    func uploadCertification(email: String, data: ProfileCertificationsModel.Certification) {
        FirebaseManager.shared.uploadFile(b64File: data.resourcePdf ?? "",
                                          email: email,
                                          type: GlobalConstants.Firestore.FileType.pdf) { [weak self] url in
            
            let auxData = ProfileCertificationsModel.Certification(certificateName: data.certificateName,
                                                                   certificateNum: data.certificateNum,
                                                                   emissionDate: data.emissionDate,
                                                                   platformEmitted: data.platformEmitted,
                                                                   resourcePdf: url)
            
            self?.saveCertificationData(data: ProfileCertificationsModel(email: email, projectInfo: [auxData]))
        } failure: { [weak self] error in
            self?.errorObservable.value = error
        }
    }
    
    private func saveCertificationData(data: ProfileCertificationsModel) {
        FirebaseManager.shared.updateData(collection: GlobalConstants.Firebase.Collections.userCertificationsCollection,
                                          document: data.email ?? "",
                                          data: data,
                                          createIfItDoesNotExist: true) { [weak self] in
            self?.uploadCertificateObservable.value = true
        } failure: { [weak self] error in
            self?.errorObservable.value = error
        }
    }
}
