//
//  AccountCreationPageViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import Foundation
import UIKit


internal protocol AccountCreationPageDelegate: AnyObject {
    func notifyAccountCreationPageNext()
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
        label.font = Fonts.RobotoBold.of(size: 28)
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
        return textField
    }()
    
    lazy var txtfCredential: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "Debe contener 8 caracteres.",
                                            placeholder: "Contraseña",
                                            delegate: self,
                                            identifier: "credential",
                                            isSecure: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var txtfCredentialConfirmation: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "Vuelve a escribir la contraseña.",
                                            placeholder: "Confirmar contraseña",
                                            delegate: self,
                                            identifier: "confirmCredential",
                                            isSecure: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    lazy var btNext: MainButton = {
        let button = MainButton(title: "Siguiente", enable: true)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btNextPressed), for: .touchUpInside)
        return button
    }()
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
        delegate?.notifyAccountCreationPageNext()
    }
}

extension AccountCreationPageViewController: BottomTitleTextFieldDelegate {
    func bottomTitleTextFieldDidChange(identifier: String, text: String) {
        print("\(identifier): \(text)")
    }
}


