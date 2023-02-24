//
//  UIViewController+Extensions.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Extensions to give an image to the tabBarItem
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func setTabBarImage(imageName: String, title: String, imageSet: String) {
        let image = UIImage(named: imageName)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        
        let ImageSelected = UIImage(named: imageSet)
        tabBarItem.selectedImage = ImageSelected
    }
}
