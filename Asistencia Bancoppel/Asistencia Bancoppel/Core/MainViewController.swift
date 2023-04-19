//
//  MainViewController.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        }
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let vcAccount = AccountHomeViewController()
        let vcTeam = TeamViewController()
        let vcProfile = ProfileViewController()
        
        vcAccount.setTabBarImage(imageName: "home", title: "Inicio", imageSet: "home_fill")
        vcTeam.setTabBarImage(imageName: "crew", title: "Equipo", imageSet: "crew_fill")
        vcProfile.setTabBarImage(imageName: "profile", title: "Perfil", imageSet: "profile_fill")

        let tabBarList = [vcAccount, vcTeam, vcProfile]

        viewControllers = tabBarList
    }
        
    private func setupTabBar() {
        tabBar.tintColor = GlobalConstants.BancoppelColors.grayBex10
        tabBar.isTranslucent = false
    }
    
}

class TeamViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
