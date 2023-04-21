//
//  CustomTabBarViewButtonModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 21/04/23.
//

import Foundation
import UIKit


struct CustomTabButtonModel {
    var title: String
    var selectedIcon: UIImage?
    var unselectedIcon: UIImage?
    var shadowStyle: CustomTabButtonShadowStyleEnum
    
    init(title: String, selectedIcon: UIImage?, unselectedIcon: UIImage?, shadowStyle: CustomTabButtonShadowStyleEnum) {
        self.title = title
        self.selectedIcon = selectedIcon
        self.unselectedIcon = unselectedIcon
        self.shadowStyle = shadowStyle
    }
}
