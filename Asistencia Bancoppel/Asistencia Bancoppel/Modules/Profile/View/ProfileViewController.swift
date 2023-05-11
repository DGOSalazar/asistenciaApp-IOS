//
//  ProfileViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 03/05/23.
//

import Foundation
import UIKit


internal class ProfileViewController: UIViewController {
    private var viewModel = ProfileViewModel()
    private var pages: [UIViewController] = []
    private var currentIndex = 0
    private var profileViewController: ProfileSummaryViewController?
    private var editting: Bool = false
    private var accountData: UserAttendanceDataModel?
    private var newProfilePhoto: UIImage?
    
    
    lazy var mainContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blueHeaderView: UIView = {
       let view = UIView()
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let bancoppelLogoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: GlobalConstants.Images.bancoppelWhite)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
 
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.backgroundColor = .clear
        button.setImage(UIImage(named: GlobalConstants.Images.menuLoginWhite), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var profilePhotoImageView: UploadPhotoButton = {
       let imageView = UploadPhotoButton(presenter: self,
                                         delegate: self,
                                         buttonSize: 120 * DeviceSize.size.getMultiplier(),
                                         showShadow: false,
                                         borderColor: .white,
                                         borderWidth: 8)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Héctor González Martínez"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var positionDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tester/QA | Iniciativa Abono Coppel "
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoRegular(ofSize: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var collaboratorNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Número de colaborador: 1234567890"
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoBold(ofSize: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()

    


    
    lazy var editProfileButton: MainButton = {
        let button = MainButton(title: "Editar perfil", enable: true, style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var profileInfoTabBar: BottomLineCustomTabBar = {
       let tabBar = BottomLineCustomTabBar(titles: ["Resumen", "Notificaciones"], delegate: self)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()
    
    lazy var profileInfoPageController: UIPageViewController = {
        let pagerView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pagerView.view.translatesAutoresizingMaskIntoConstraints = false
        return pagerView
    }()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTapped()
        
        setComponents()
        setAutolayout()
        
        setPager()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CustomLoader.show()
        viewModel.getAccountMoreData(email: accountData?.email ?? "")
    }
    
    
    private func setComponents() {
        self.view.addSubview(mainContainerView)
        
        mainContainerView.addSubview(topContainerView)
        topContainerView.addSubview(blueHeaderView)
        topContainerView.addSubview(profilePhotoImageView)
        topContainerView.addSubview(userNameLabel)
        topContainerView.addSubview(positionDataLabel)
        topContainerView.addSubview(collaboratorNumberLabel)
        topContainerView.addSubview(editProfileButton)
        
        mainContainerView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(profileInfoTabBar)
        
        self.addChild(profileInfoPageController)
        bottomContainerView.addSubview(profileInfoPageController.view)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            
            topContainerView.topAnchor.constraint(equalTo: mainContainerView.safeAreaLayoutGuide.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            blueHeaderView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            blueHeaderView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            blueHeaderView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            blueHeaderView.heightAnchor.constraint(equalToConstant: 100 * DeviceSize.size.getMultiplier()),
            
            profilePhotoImageView.centerYAnchor.constraint(equalTo: blueHeaderView.bottomAnchor),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            profilePhotoImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: Dimensions.margin10),
            userNameLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: Dimensions.margin20),
            userNameLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -Dimensions.margin20),
            
            positionDataLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: Dimensions.margin10),
            positionDataLabel.leadingAnchor.constraint(greaterThanOrEqualTo: topContainerView.leadingAnchor, constant: Dimensions.margin20),
            positionDataLabel.trailingAnchor.constraint(lessThanOrEqualTo: topContainerView.trailingAnchor, constant: -Dimensions.margin20),
            positionDataLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            
            collaboratorNumberLabel.topAnchor.constraint(equalTo: positionDataLabel.bottomAnchor, constant: Dimensions.margin10),
            collaboratorNumberLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: Dimensions.margin20),
            collaboratorNumberLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -Dimensions.margin20),
            
            editProfileButton.topAnchor.constraint(equalTo: collaboratorNumberLabel.bottomAnchor, constant: Dimensions.margin20),
            editProfileButton.heightAnchor.constraint(equalToConstant: 50),
            editProfileButton.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.4),
            editProfileButton.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            editProfileButton.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -Dimensions.margin20),
            
            
            bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            profileInfoTabBar.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            profileInfoTabBar.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            profileInfoTabBar.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            
            
            profileInfoPageController.view.topAnchor.constraint(equalTo: profileInfoTabBar.bottomAnchor),
            profileInfoPageController.view.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            profileInfoPageController.view.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            profileInfoPageController.view.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
        ])
    }
    
    
    internal func setData(data: UserAttendanceDataModel) {
        DispatchQueue.main.async {
            self.accountData = data
            self.profilePhotoImageView.setPreviewImage(image: data.profilePhoto ?? UIImage())
            self.userNameLabel.text = data.fullname
            self.positionDataLabel.text = "\(data.position.rawValue) | \(data.team ?? "")"
            self.positionDataLabel.backgroundColor = data.position.getColor()
            self.collaboratorNumberLabel.text = "Número de colaborador: \(data.employee ?? 0)"
        }
    }
    
    private func setPager() {
        let profileSummaryViewController = ProfileSummaryViewController()
        self.profileViewController = profileSummaryViewController
        profileViewController?.delegate = self
        
        
        let notificationsViewController = ProfileNotificationsViewController()
        notificationsViewController.setData(data: [ProfileNotificationModel(image: nil,
                                                                            title: "Diana Fernández Huerta te ha registrado asistencia para el Viernes 3 de Febrero.",
                                                                            date: Date(),
                                                                            type: .profile),
                                                   ProfileNotificationModel(image: nil,
                                                                            title: "¡Recuerda asistir el día de mañana a la oficina!",
                                                                            date: Date(),
                                                                            type: .check),
                                                   ProfileNotificationModel(image: nil,
                                                                            title: "Recuerda llenar tu Time Report antes del Lunes.",
                                                                            date: Date(),
                                                                            type: .time),
                                                   ProfileNotificationModel(image: nil,
                                                                            title: "Recuerda realizar tu Registro de comidas.",
                                                                            date: Date(),
                                                                            type: .dinner),
                                                   ProfileNotificationModel(image: nil,
                                                                            title: "Hoy es cumpleaños de Fernanda Tamayo Rodríguez ¡Felicítala!",
                                                                            date: Date(),
                                                                            type: .profile)])
        pages.append(profileSummaryViewController)
        profileInfoPageController.addChild(profileSummaryViewController)
        
        pages.append(notificationsViewController)
        profileInfoPageController.addChild(notificationsViewController)
        
        profileInfoPageController.setViewControllers([pages[self.currentIndex]], direction: .forward, animated: true)
    }
     

    
    @objc private func editProfileButtonTapped() {
        profileViewController?.setEditable(edit: !editting)
        editProfileButton.setTitle(editting ? "Editar perfil" : "Listo", for: .normal)
        editting = !editting
    }
    
    private func bind() {
        viewModel.accountGetMoreDataDataObservable.observe = { [weak self] response in
            guard let nonNilResponse = response else {
                CustomLoader.hide()
                self?.profileViewController?.setSummaryData(data: AccountMoreDataModel(email: self?.accountData?.email ?? ""))
                return
            }
            
            let (accountMoreData, _) = nonNilResponse
            
            guard let nonNilData = accountMoreData else {
                CustomLoader.hide()
                self?.profileViewController?.setSummaryData(data: AccountMoreDataModel(email: self?.accountData?.email ?? ""))
                return
            }
            self?.viewModel.getCertifications(email: self?.accountData?.email ?? "")
            self?.viewModel.getProjects(email: self?.accountData?.email ?? "")
            self?.profileViewController?.setSummaryData(data: nonNilData)
        }
        
        
        viewModel.accountSaveMoreDataDataObservable.observe = { _ in
            CustomLoader.hide()
        }
        
        
        viewModel.accountUpdateProfilePhoto.observe = { _ in
            CustomLoader.hide()
        }
        
        
        viewModel.getProjectsObservable.observe = { [weak self] response in
            CustomLoader.hide()
            
            guard let nonNilResponse = response else {
                self?.profileViewController?.setProjects(data: [])
                return
            }
            
            let (accountProjects, _) = nonNilResponse
            
            guard let nonNilData = accountProjects?.projectInfo else {
                self?.profileViewController?.setProjects(data: [])
                return
            }
            
            self?.profileViewController?.setProjects(data: nonNilData)
        }
        
        
        viewModel.uploadProjectObservable.observe = { [weak self] _ in
            self?.viewModel.getProjects(email: self?.accountData?.email ?? "")
        }
        
        
        viewModel.getCertificationsObservable.observe = { [weak self] response in
            CustomLoader.hide()
    
            guard let nonNilResponse = response else {
                self?.profileViewController?.setCertifications(data: [])
                return
            }
            
            let (accountCertifications, _) = nonNilResponse
            
            guard let nonNilData = accountCertifications?.projectInfo else {
                self?.profileViewController?.setCertifications(data: [])
                return
            }
            
            self?.profileViewController?.setCertifications(data: nonNilData)
        }
        
        
        viewModel.uploadCertificateObservable.observe = { [weak self] _ in
            self?.viewModel.getCertifications(email: self?.accountData?.email ?? "")
        }
        
        viewModel.errorObservable.observe = { [weak self] error in
            self?.showAlert(message: error ?? "Error desconocido", isError: true)
        }
    }
    
    
    private func showAlert(message: String, isError: Bool = false) {
        DispatchQueue.main.async {
            CustomLoader.hide()
            
            let alert = UIAlertController(title: isError ? "Error" : "Información",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension ProfileViewController: UploadPhotoButtonDelegate {
    func notifyPhotoSelected(photo: UIImage) {
        CustomLoader.show()
        viewModel.uploadPhoto(email: accountData?.email ?? "", photo: photo)
    }
}


extension ProfileViewController: BottomLineCustomTabBarDelegate {
    func notifyBottomLineCustomTabBarTapped(tag: Int) {
        DispatchQueue.main.async {
            guard tag < self.pages.count, tag >= 0 else {
                return
            }
            self.profileInfoPageController.setViewControllers([self.pages[tag]],
                                                    direction: self.currentIndex < tag ? .forward : .reverse,
                                                    animated: true)
            self.currentIndex = tag
        }
    }
}


extension ProfileViewController: ProfileSummaryViewDelegate {
    func notifyUploadProject(data: ProfileProjectsModel.Project) {
        CustomLoader.show()
        viewModel.uploadProject(email: accountData?.email ?? "", data: data)
    }
    
    func notifyUploadCertification(data: ProfileCertificationsModel.Certification) {
        CustomLoader.show()
        viewModel.uploadCertification(email: accountData?.email ?? "", data: data)
    }
    
    func notifyNeedUpdateAccountMoreData(data: AccountMoreDataModel) {
        CustomLoader.show()
        viewModel.saveAccountMoreData(data: data)
    }
}


