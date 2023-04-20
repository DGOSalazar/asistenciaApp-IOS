//
//  AccountCreationPageViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import Foundation
import UIKit


internal protocol AccountCreationPageDelegate: AnyObject {
    func notifyAccountCreationPageNext(email: String, credential: String)
}


internal class AccountCreationPageViewController: UIViewController {
    internal weak var delegate: AccountCreationPageDelegate?
    
    
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Crear una cuenta"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 28)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var vwContent: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwDataContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var txtfEmail: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "Ingresa tu correo Coppel.",
                                            placeholder: "Correo electrónico",
                                            delegate: self,
                                            identifier: "email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.inputValidation = .email
        textField.maxLength = 40
        return textField
    }()
    
    lazy var txtfCredential: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "Debe contener 8 caracteres.",
                                            placeholder: "Contraseña",
                                            delegate: self,
                                            identifier: "credential",
                                            isSecure: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.allowSpaces = false
        textField.maxLength = 40
        return textField
    }()
    
    lazy var txtfCredentialConfirmation: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "Vuelve a escribir la contraseña.",
                                            placeholder: "Confirmar contraseña",
                                            delegate: self,
                                            identifier: "confirmCredential",
                                            isSecure: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.allowSpaces = false
        textField.maxLength = 40
        return textField
    }()
    
    
    lazy var btNext: MainButton = {
        let button = MainButton(title: "Siguiente", enable: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btNextPressed), for: .touchUpInside)
        return button
    }()
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTapped()
        setComponents()
        setAutolayout()
    }
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        
        vwContainer.addSubview(lbTitle)
        vwContainer.addSubview(vwContent)
        
        vwContent.addSubview(vwDataContainer)
        vwDataContainer.addSubview(txtfEmail)
        vwDataContainer.addSubview(txtfCredential)
        vwDataContainer.addSubview(txtfCredentialConfirmation)
        vwContainer.addSubview(btNext)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            lbTitle.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 50),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            
            vwContent.topAnchor.constraint(equalTo: lbTitle.bottomAnchor),
            vwContent.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 20),
            vwContent.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -20),
            vwContent.bottomAnchor.constraint(equalTo: btNext.topAnchor),
            
            vwDataContainer.topAnchor.constraint(greaterThanOrEqualTo: vwContent.topAnchor),
            vwDataContainer.centerYAnchor.constraint(equalTo: vwContent.centerYAnchor),
            vwDataContainer.leadingAnchor.constraint(equalTo: vwContent.leadingAnchor),
            vwDataContainer.trailingAnchor.constraint(equalTo: vwContent.trailingAnchor),
            vwDataContainer.bottomAnchor.constraint(lessThanOrEqualTo: vwContent.bottomAnchor),
            
            txtfEmail.topAnchor.constraint(equalTo: vwDataContainer.topAnchor),
            txtfEmail.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfEmail.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfCredential.topAnchor.constraint(equalTo: txtfEmail.bottomAnchor, constant: 20),
            txtfCredential.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfCredential.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfCredentialConfirmation.topAnchor.constraint(equalTo: txtfCredential.bottomAnchor, constant: 20),
            txtfCredentialConfirmation.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfCredentialConfirmation.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            txtfCredentialConfirmation.bottomAnchor.constraint(equalTo: vwDataContainer.bottomAnchor),
            
            btNext.heightAnchor.constraint(equalToConstant: 59),
            btNext.widthAnchor.constraint(equalToConstant: 200),
            btNext.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btNext.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func btNextPressed() {
        guard validateData() else {
            return
        }
        
        delegate?.notifyAccountCreationPageNext(email: txtfEmail.getText(),
                                                credential: txtfCredential.getText())
    }
    
    private func validateEmail() -> Bool {
        let email = txtfEmail.getText().lowercased()
        guard !email.isEmpty, email.contains("@") else {
            txtfEmail.setDefaultStatus()
            return false
        }
        
        guard email.isCoppelEmail() else {
            txtfEmail.setFailureStatus(message: "Ingresa un correo Coppel válido.")
            return false
        }
        
        txtfEmail.setSuccessStatus()
        return true
    }
    
    private func validatedCredential() -> Bool {
        let credential = txtfCredential.getText()
        
        if !txtfCredentialConfirmation.getText().isEmpty {
            _ = validatedConfirmCredential()
        }
        
        guard !credential.isEmpty else {
            txtfCredential.setDefaultStatus()
            return false
        }
        
        guard credential.count >= 8 else {
            txtfCredential.setFailureStatus(message: "Ingresa una contraseña válida (al menos 8 caracteres).")
            return false
        }
        
        txtfCredential.setSuccessStatus()
        
        return true
    }
    
    private func validatedConfirmCredential() -> Bool{
        let confirmCredential = txtfCredentialConfirmation.getText()
        
        guard !confirmCredential.isEmpty else {
            txtfCredentialConfirmation.setDefaultStatus()
            return false
        }
        
        guard confirmCredential.count >= 8 else {
            txtfCredentialConfirmation.setFailureStatus(message: "Ingresa una contraseña válida (al menos 8 caracteres).")
            return false
        }
        
        guard confirmCredential == txtfCredential.getText() else {
            txtfCredentialConfirmation.setFailureStatus(message: "La contraseñas no coinciden.")
            return false
        }
        
        txtfCredentialConfirmation.setSuccessStatus()
        return true
    }
    
    private func validateData() -> Bool {
        let isValidEmail = validateEmail()
        let isValidCredential = validatedCredential()
        let isValidConfirmCredential = validatedConfirmCredential()
        return (isValidEmail && isValidCredential && isValidConfirmCredential)
    }
}

extension AccountCreationPageViewController: BottomTitleTextFieldDelegate {
    func bottomTitleTextFieldDidChange(identifier: String, text: String) {
        btNext.setStatus(enable: validateData())
    }
    
    func bottomTitleTextFieldDone(identifier: String) {
        if identifier == txtfEmail.identifier {
            _ = txtfCredential.becomeFirstResponder()
        } else if identifier == txtfCredential.identifier {
            _ = txtfCredentialConfirmation.becomeFirstResponder()
        } else if identifier == txtfCredentialConfirmation.identifier {
            _ = txtfCredentialConfirmation.resignFirstResponder()
        }
    }
}


