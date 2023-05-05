//
//  ProfileNotificationsViewController.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation
import UIKit


internal class ProfileNotificationsViewController: UIViewController {
    private var notifications: [ProfileNotificationModel] = []
    
    lazy var mainContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    private lazy var notificationsTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileNotificationsViewCell.self, forCellReuseIdentifier: ProfileNotificationsViewCell.identifier)
        tableView.rowHeight = ProfileNotificationsViewCell.rowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTapped()
        
        setComponents()
        setAutolayout()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func setComponents() {
        self.view.addSubview(mainContainerView)
        
        mainContainerView.addSubview(notificationsTable)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            notificationsTable.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            notificationsTable.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            notificationsTable.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            notificationsTable.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
        ])
    }
    
    func setData(data: [ProfileNotificationModel]) {
        DispatchQueue.main.async {
            self.notifications = data
            self.notificationsTable.reloadData()
        }
    }
}


extension ProfileNotificationsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !notifications.isEmpty else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNotificationsViewCell.identifier, for: indexPath) as? ProfileNotificationsViewCell
        
        guard let nonNilCell = cell else { return UITableViewCell() }
        
        nonNilCell.setCell(data: notifications[indexPath.row], delegate: self)

        return nonNilCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

}



extension ProfileNotificationsViewController: ProfileNotificationsViewCellDelegate {
    func notifyProfileNotificationsViewCellTapped(data: ProfileNotificationModel?) {
        print(data)
    }
}
