//
//  ProfileSummaryViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 04/05/23.
//

import Foundation
import UIKit


internal class ProfileSummaryViewController: UIViewController {
    private var certifications: [ProfileCertificationsModel.Certification] = []
    private var projects: [ProfileProjectsModel.Project] = []
    private let initiativesTableTag = 1
    private let certificationsTableTag = 2
    
    lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerScroll: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Dimensions.margin10
        return stack
    }()
    
    lazy var personalInfoContainerView: CollapsableView = {
       let view = CollapsableView(title: "Información personal",
                                       contentView: personalInfoStack,
                                       collapsable: false,
                                       canUserAdd: false,
                                       identifier: "personalInfoContainer",
                                       delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var personalInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = Dimensions.margin10
        return stack
    }()

    lazy var managerLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Gerente:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "manager")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var leaderLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Manager:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "manager")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var teamLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Iniciativa:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "manager")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scrumMasterLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Scrum Master:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "manager")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    lazy var initiativesFinishedContainerView: CollapsableView = {
       let view = CollapsableView(title: "Iniciativas concluidas",
                                       contentView: initiativesFinishedTable,
                                       collapsable: true,
                                       canUserAdd: true,
                                       identifier: "initiativesFinished",
                                       delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var initiativesFinishedTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileInitiativesViewCell.self, forCellReuseIdentifier: ProfileInitiativesViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ProfileInitiativesViewCell.rowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .clear
        tableView.tag = initiativesTableTag
        
        return tableView
    }()

    
    
    lazy var certificationsContainerView: CollapsableView = {
       let view = CollapsableView(title: "Certificaciones",
                                       contentView: certificationsTable,
                                       collapsable: true,
                                       canUserAdd: true,
                                       identifier: "certifications",
                                       delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var certificationsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileCertificationsViewCell.self, forCellReuseIdentifier: ProfileCertificationsViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ProfileCertificationsViewCell.rowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .clear
        tableView.tag = certificationsTableTag

        return tableView
    }()
    
    
    
    lazy var historyContainerView: CollapsableView = {
       let view = CollapsableView(title: "Historial",
                                       contentView: historyStack,
                                       collapsable: false,
                                       canUserAdd: false,
                                       identifier: "personalInfoContainer",
                                       delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var historyStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = Dimensions.margin10
        return stack
    }()
    
    lazy var enrollmentDateLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Fecha de ingreso:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "enrollmentDate")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var workedDaysLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Días laborados:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "workedDays")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var homeOfficeDaysLabel: EditableLabelTextField = {
       let label = EditableLabelTextField(title: "Días en oficina:",
                                          placeholder: "",
                                          delegate: self,
                                          identifier: "homeOfficeDays")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        mainContainerView.addSubview(containerScroll)
        
        containerScroll.addSubview(contentStack)
        
        contentStack.addArrangedSubview(personalInfoContainerView)
        contentStack.addArrangedSubview(initiativesFinishedContainerView)
        contentStack.addArrangedSubview(certificationsContainerView)
        contentStack.addArrangedSubview(historyContainerView)
        
        personalInfoStack.addArrangedSubview(managerLabel)
        personalInfoStack.addArrangedSubview(leaderLabel)
        personalInfoStack.addArrangedSubview(teamLabel)
        personalInfoStack.addArrangedSubview(scrumMasterLabel)
        
        historyStack.addArrangedSubview(enrollmentDateLabel)
        historyStack.addArrangedSubview(workedDaysLabel)
        historyStack.addArrangedSubview(homeOfficeDaysLabel)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            containerScroll.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            containerScroll.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin20),
            containerScroll.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin20),
            containerScroll.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            
            contentStack.topAnchor.constraint(equalTo: containerScroll.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: containerScroll.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: containerScroll.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: containerScroll.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: containerScroll.widthAnchor)
        ])
    }
    
    
    internal func setEditable(edit: Bool) {
        managerLabel.setEditable(edit: edit)
        leaderLabel.setEditable(edit: edit)
        teamLabel.setEditable(edit: edit)
        scrumMasterLabel.setEditable(edit: edit)
        
        enrollmentDateLabel.setEditable(edit: edit)
        workedDaysLabel.setEditable(edit: edit)
        homeOfficeDaysLabel.setEditable(edit: edit)
    }
    
    func setProjects(data: [ProfileProjectsModel.Project]) {
        DispatchQueue.main.async {
            self.projects = data
            self.initiativesFinishedTable.reloadData()
        }
    }
    
    func setCertifications(data: [ProfileCertificationsModel.Certification]) {
        DispatchQueue.main.async {
            self.certifications = data
            self.certificationsTable.reloadData()
        }
    }
}


extension ProfileSummaryViewController: CollapsableViewDelegate {
    func notifyCollapsableViewAddElement(identifier: String) {
        print("add element \(identifier)")
    }
}


extension ProfileSummaryViewController: EditableLabelTextFieldDelegate {
    func editableLabelTextFieldDidChange(identifier: String, text: String) {
        print("\(identifier): \(text)")
    }
}




extension ProfileSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == initiativesTableTag {
            return projects.count
        } else if tableView.tag == certificationsTableTag {
            return certifications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == initiativesTableTag {
            guard !projects.isEmpty, projects.count > indexPath.row else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInitiativesViewCell.identifier, for: indexPath) as? ProfileInitiativesViewCell
            guard let nonNilCell = cell else { return UITableViewCell() }
            nonNilCell.setCell(data: projects[indexPath.row])

            return nonNilCell
        } else if tableView.tag == certificationsTableTag {
            guard !certifications.isEmpty, certifications.count > indexPath.row  else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCertificationsViewCell.identifier, for: indexPath) as? ProfileCertificationsViewCell
            guard let nonNilCell = cell else { return UITableViewCell() }
            nonNilCell.setCell(data: certifications[indexPath.row])

            return nonNilCell
        }
        
        return UITableViewCell()
    }
    
    
}
