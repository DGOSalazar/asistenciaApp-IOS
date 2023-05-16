//
//  ProfileNotificationModel.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation
import UIKit


struct ProfileNotificationModel {
    var image: UIImage?
    var title: String
    var date: String
    var type: ProfileNotificationTypeEnum
    
    init (image: UIImage?, title: String, date: String, type: ProfileNotificationTypeEnum) {
        self.image = image
        self.title = title
        self.date = date
        self.type = type
    }
}
