//
//  AccountCreationViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 24/04/23.
//

import Foundation
import UIKit


internal class AccountCreationViewController: UIViewController {
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ivwLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoCoppelAsistenciaColored")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    lazy var vwContainerScroll: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwContentContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwDataContainerStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = Dimensions.margin20
        return view
    }()
    
    lazy var txtfEmail: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "Ingresa tu correo Coppel.",
                                            placeholder: "Correo electrónico",
                                            delegate: self,
                                            identifier: "email",
                                            casing: .lowercased)
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
    
    
    lazy var pageIndicatorView: PageIndicatorView = {
       let view = PageIndicatorView(selectedIndex: 0, delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        self.hideKeyboardWhenTapped()
        
        setComponents()
        setAutolayout()
    }
    
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        vwContainer.addSubview(ivwLogo)
        vwContainer.addSubview(lbTitle)
        
        
        vwContainer.addSubview(vwContainerScroll)
        vwContainerScroll.addSubview(vwContentContainer)
        vwContentContainer.addSubview(vwDataContainerStack)
        vwDataContainerStack.addArrangedSubview(txtfEmail)
        vwDataContainerStack.addArrangedSubview(txtfCredential)
        vwDataContainerStack.addArrangedSubview(txtfCredentialConfirmation)
        
        vwContainer.addSubview(btNext)
        vwContainer.addSubview(pageIndicatorView)
    }
    
    private func setAutolayout() {
        let contentHeightAnchor = vwContentContainer.heightAnchor.constraint(equalTo: vwContainerScroll.heightAnchor)
        contentHeightAnchor.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ivwLogo.topAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.topAnchor, constant: Dimensions.margin40),
            ivwLogo.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin80),
            ivwLogo.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin80),
            ivwLogo.heightAnchor.constraint(equalToConstant: (50 * DeviceSize.size.getMultiplier())),
            
            lbTitle.topAnchor.constraint(equalTo: ivwLogo.bottomAnchor, constant: Dimensions.margin60),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            
            vwContainerScroll.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: Dimensions.margin40),
            vwContainerScroll.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin40),
            vwContainerScroll.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin40),
            vwContainerScroll.bottomAnchor.constraint(equalTo: btNext.topAnchor, constant: -Dimensions.margin40),
            
            
            vwContentContainer.topAnchor.constraint(equalTo: vwContainerScroll.topAnchor),
            vwContentContainer.leadingAnchor.constraint(equalTo: vwContainerScroll.leadingAnchor),
            vwContentContainer.trailingAnchor.constraint(equalTo: vwContainerScroll.trailingAnchor),
            vwContentContainer.bottomAnchor.constraint(equalTo: vwContainerScroll.bottomAnchor),
            vwContentContainer.widthAnchor.constraint(equalTo: vwContainerScroll.widthAnchor),
            contentHeightAnchor,
            
            vwDataContainerStack.topAnchor.constraint(greaterThanOrEqualTo: vwContentContainer.topAnchor),
            vwDataContainerStack.leadingAnchor.constraint(equalTo: vwContentContainer.leadingAnchor),
            vwDataContainerStack.trailingAnchor.constraint(equalTo: vwContentContainer.trailingAnchor),
            vwDataContainerStack.bottomAnchor.constraint(lessThanOrEqualTo: vwContentContainer.bottomAnchor),
            vwDataContainerStack.centerYAnchor.constraint(equalTo: vwContentContainer.centerYAnchor),
            
            
            btNext.heightAnchor.constraint(equalToConstant: 59),
            btNext.widthAnchor.constraint(equalTo: vwContainer.widthAnchor, multiplier: 0.6),
            btNext.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btNext.bottomAnchor.constraint(equalTo: pageIndicatorView.topAnchor, constant: -Dimensions.margin40),
            
            
            pageIndicatorView.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            pageIndicatorView.bottomAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin40),
        ])
    }

    
    @objc private func btNextPressed() {
        guard validateData() else {
            return
        }
        
        let viewController = PersonalDataViewController()
        viewController.model.email = txtfEmail.getText().lowercased()
        viewController.credential = txtfCredential.getText()
        self.navigationController?.pushViewController(viewController, animated: true)
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

extension AccountCreationViewController: BottomTitleTextFieldDelegate {
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


extension AccountCreationViewController: PageIndicatorViewDelegate {
    func notifyPageIndicatorViewTapped(index: Int) {
        print(index)
    }
}
