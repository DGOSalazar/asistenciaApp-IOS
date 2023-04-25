//
//  MainPagerViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 21/04/23.
//

import Foundation
import UIKit


internal class MainPagerViewController: UIViewController {
    private var pages: [UIViewController] = []
    internal var email: String = ""
    private var currentIndex = 0
    
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pagerController: UIPageViewController = {
        let pagerView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pagerView.view.translatesAutoresizingMaskIntoConstraints = false
        return pagerView
    }()
    
    lazy var customTabBar: CustomTabBarView = {
       let tabBar = CustomTabBarView(buttons: [], delegate: self)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        self.hideKeyboardWhenTapped()
        
        setComponents()
        setAutolayout()
        setPager()
    }
    
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        self.addChild(pagerController)
        vwContainer.addSubview(pagerController.view)
        vwContainer.addSubview(customTabBar)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            pagerController.view.topAnchor.constraint(equalTo: vwContainer.topAnchor),
            pagerController.view.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            pagerController.view.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            pagerController.view.bottomAnchor.constraint(equalTo: customTabBar.topAnchor),
            
            customTabBar.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor),
        ])
    }
    
    private func setPager() {
        let accountViewController = AccountHomeViewController()
        accountViewController.email = email
        let accountTabButton = CustomTabButtonModel(title: "Inicio",
                                                    selectedIcon: UIImage(named: "home_fill"),
                                                    unselectedIcon: UIImage(named: "home"),
                                                    shadowStyle: .shadowToTheRight)
        let teamViewController = TeamViewController()
        let teamTabButton = CustomTabButtonModel(title: "Equipo",
                                                    selectedIcon: UIImage(named: "crew_fill"),
                                                    unselectedIcon: UIImage(named: "crew"),
                                                 shadowStyle: .centerShadow)
        let profileViewController = ProfileViewController()
        let profileTabButton = CustomTabButtonModel(title: "Perfil",
                                                    selectedIcon: UIImage(named: "profile_fill"),
                                                    unselectedIcon: UIImage(named: "profile"),
                                                    shadowStyle: .shadowToTheLeft)
        
        pages.append(accountViewController)
        pagerController.addChild(accountViewController)

        pages.append(teamViewController)
        pagerController.addChild(teamViewController)
        
        pages.append(profileViewController)
        pagerController.addChild(profileViewController)
        
        customTabBar.addButtons(buttons: [accountTabButton, teamTabButton, profileTabButton])
        
        pagerController.setViewControllers([pages[self.currentIndex]], direction: .forward, animated: true)
    }
}


extension MainPagerViewController: CustomTabBarViewDelegate {
    func notifyCustomTabBarButtonTapped(tag: Int) {
        DispatchQueue.main.async {
            guard tag < self.pages.count, tag >= 0 else {
                return
            }
            self.pagerController.setViewControllers([self.pages[tag]],
                                                    direction: self.currentIndex < tag ? .forward : .reverse,
                                                    animated: true)
            self.currentIndex = tag
        }
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
