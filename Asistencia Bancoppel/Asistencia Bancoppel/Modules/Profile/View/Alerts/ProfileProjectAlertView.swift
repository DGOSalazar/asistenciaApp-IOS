//
//  ProfileInitiativeAlertView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 11/05/23.
//

import Foundation
import UIKit


protocol ProfileProjectAlertDelegate: AnyObject {
    func notifyProfileProjectConfirm(data: ProfileProjectsModel.Project)
}


internal class ProfileProjectAlertView: UIViewController {
    internal var delegate: ProfileProjectAlertDelegate?
    private var modelData = ProfileProjectsModel.Project()
    
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex10.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var alertContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var topContentStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = Dimensions.margin20
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Agregar nuevo proyecto"
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoBold(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Ingresa los datos del proyecto liberado"
        return label
    }()
    
    
    lazy var middleContentStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var projectNameTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
                                            placeholder: "Nombre del proyecto",
                                            delegate: self,
                                            identifier: "projectName")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputValidation = .spaAlphanumeric
        textField.maxLength = 40
        return textField
    }()
    

    lazy var projectReleaseTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
                                            placeholder: "Liberado en el Q",
                                            delegate: self,
                                            identifier: "projectRelease")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputValidation = .numeric
        textField.keyboardType = .numberPad
        textField.maxLength = 10
        return textField
    }()
 
    
    
    private lazy var cancelButton: MainButton = {
       let button = MainButton(title: "Volver",
                               enable: true,
                               style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: MainButton = {
       let button = MainButton(title: "Confirmar",
                               enable: false,
                               style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.overrideWithFont = .robotoBold(ofSize: 18)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    required init(delegate: ProfileProjectAlertDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        
        self.delegate = delegate
        
        setComponents()
        setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
    }
    

    private func setComponents() {
        self.view.addSubview(mainContainerView)
        mainContainerView.addSubview(backgroundView)
        mainContainerView.addSubview(alertContainerView)
        
        alertContainerView.addSubview(topContentStack)
        topContentStack.addArrangedSubview(titleLabel)
        topContentStack.addArrangedSubview(separatorLineView)
        topContentStack.addArrangedSubview(subtitleLabel)
        
        alertContainerView.addSubview(middleContentStack)
        middleContentStack.addArrangedSubview(projectNameTextField)
        middleContentStack.addArrangedSubview(projectReleaseTextField)

        alertContainerView.addSubview(cancelButton)
        alertContainerView.addSubview(confirmButton)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            alertContainerView.topAnchor.constraint(greaterThanOrEqualTo: mainContainerView.safeAreaLayoutGuide.topAnchor, constant: Dimensions.margin20),
            alertContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin20),
            alertContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin20),
            alertContainerView.bottomAnchor.constraint(lessThanOrEqualTo: mainContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin20),
            alertContainerView.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            
            
            
            topContentStack.topAnchor.constraint(equalTo: alertContainerView.topAnchor, constant: Dimensions.margin20),
            topContentStack.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            topContentStack.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
 
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            
            
            middleContentStack.topAnchor.constraint(equalTo: topContentStack.bottomAnchor, constant: Dimensions.margin20),
            middleContentStack.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            middleContentStack.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
  
 
            cancelButton.topAnchor.constraint(equalTo: middleContentStack.bottomAnchor, constant: Dimensions.margin20),
            cancelButton.trailingAnchor.constraint(equalTo: alertContainerView.centerXAnchor, constant: -Dimensions.margin5),
            cancelButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            cancelButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.4),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            confirmButton.topAnchor.constraint(equalTo: middleContentStack.bottomAnchor, constant: Dimensions.margin20),
            confirmButton.leadingAnchor.constraint(equalTo: alertContainerView.centerXAnchor, constant: Dimensions.margin5),
            confirmButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            confirmButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.4),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }


    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func confirmButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.notifyProfileProjectConfirm(data: self.modelData)
        }
    }
    

    private func validateName() -> Bool {
        let name = projectNameTextField.getText()
        guard !name.isEmpty else {
            return false
        }
    
        modelData.projectName = name
        return true
    }

    private func validateRelease() -> Bool {
        let release = projectReleaseTextField.getText()
        guard !release.isEmpty else {
            return false
        }
    
        modelData.releaseDate = release
        return true
    }
    
    private func validateData() {
        self.confirmButton.setStatus(enable: (validateName() &&
                                              validateRelease()))
    }
}



extension ProfileProjectAlertView: BottomTitleTextFieldDelegate {
    func bottomTitleTextFieldDidChange(identifier: String, text: String) {
        validateData()
    }
    func bottomTitleTextFieldDone(identifier: String) {
        if identifier == projectNameTextField.identifier {
            _ = projectReleaseTextField.becomeFirstResponder()
        } else if identifier == projectReleaseTextField.identifier {
            _ = projectReleaseTextField.resignFirstResponder()
        }
    }
}

