//
//  CreateAccountViewController.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 14/02/23.
//

import UIKit

// MARK: CreateAccount 1st View
class CreateAccountViewController1: UIViewController {
    
    var mail: String? {
        return mailTextField.text
    }
    var password: String? {
        return passTextField.text
    }
    var confPassword: String? {
        return confPassTextField.text
    }
    let logoAsistView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let createTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crear una cuenta"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let mailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Correo Electronico"
        textField.font = UIFont(name: "Roboto-Regular", size: 12)
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let mailLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingresa tu correo coppel"
        label.font = UIFont(name: "Roboto-Italic", size: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let passTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.font = UIFont(name: "Roboto-Regular", size: 12)
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Debe contener 8 caracteres."
        label.font = UIFont(name: "Roboto-Italic", size: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let confPassTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirmar contraseña"
        textField.font = UIFont(name: "Roboto-Regular", size: 12)
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let confPassLabel: UILabel = {
        let label = UILabel()
        label.text = "Vuelva a escribir la contraseña."
        label.font = UIFont(name: "Roboto-Italic", size: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let confPassStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var nextButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Siguiente", for: [])
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 30
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 22)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("Cancelar", for: [])
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mailTextField.delegate = self
        passTextField.delegate = self
        autolayout()

        
        
    }
// MARK: CreateAccount1 Autolayot
    func autolayout() {
        
        view.addSubview(logoAsistView)
        view.addSubview(createTitleLabel)
        
        mailStackView.addArrangedSubview(mailTextField)
        mailStackView.addArrangedSubview(mailLabel)
        dataStackView.addArrangedSubview(mailStackView)
        
        passStackView.addArrangedSubview(passTextField)
        passStackView.addArrangedSubview(passLabel)
        dataStackView.addArrangedSubview(passStackView)
        
        confPassStackView.addArrangedSubview(confPassTextField)
        confPassStackView.addArrangedSubview(confPassLabel)
        dataStackView.addArrangedSubview(confPassStackView)
        
        view.addSubview(dataStackView)
         
         view.addSubview(nextButton)
        view.addSubview(cancelButton)
        
        
        NSLayoutConstraint.activate([
            logoAsistView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoAsistView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistView.heightAnchor.constraint(equalToConstant: 60),
            logoAsistView.widthAnchor.constraint(equalToConstant: 250),
            
            createTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createTitleLabel.topAnchor.constraint(equalTo: logoAsistView.bottomAnchor, constant: 90),
            
            mailStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailStackView.trailingAnchor, multiplier: 5),
            
            mailTextField.heightAnchor.constraint(equalToConstant: 30),
            mailTextField.widthAnchor.constraint(equalTo: mailStackView.widthAnchor),
            
            passStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passStackView.trailingAnchor, multiplier: 5),
            
            passTextField.heightAnchor.constraint(equalToConstant: 30),
            passTextField.widthAnchor.constraint(equalTo: passStackView.widthAnchor),
            
            confPassStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: confPassStackView.trailingAnchor, multiplier: 5),
            
            confPassTextField.heightAnchor.constraint(equalToConstant: 30),
            confPassTextField.widthAnchor.constraint(equalTo: confPassStackView.widthAnchor),
            
            dataStackView.topAnchor.constraint(equalTo: createTitleLabel.bottomAnchor, constant: 50),
                        
            nextButton.topAnchor.constraint(equalTo: dataStackView.bottomAnchor, constant: 100),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
        
    }
}
// MARK: CreateAccount1 TextField Delegates
extension CreateAccountViewController1: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailTextField.endEditing(true)
        passTextField.endEditing(true)
        confPassTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if check(){
            nextButton.tintColor = UIColor(named: "splashGradientTop")
        }

        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

extension CreateAccountViewController1 {
    @objc func nextButtonTapped(sender: UIButton) {
        
        if check(){
            let createAcc2VC = CreateAccountViewController2()
            createAcc2VC.modalPresentationStyle = .fullScreen
            self.present(createAcc2VC, animated: true)
        }
    }
    
    @objc func cancelButtonTapped(){
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    private func check() -> Bool {
        
        let tfError = ["Ingresa un correo Coppel valido.",
                       "Ingresa una contraseña valida (al menos 8 caracteres).",
                       "Las contraseñas no coinciden.",
                       "Vuelve a escribir la contraseña"]
        
        var flag = true
        mailLabel.text = "Ingresa tu correo coppel"
        mailLabel.textColor = .gray
        mailTextField.layer.borderWidth = 0
        passLabel.text = "Debe contener 8 caracteres."
        passLabel.textColor = .gray
        passTextField.layer.borderWidth = 0
        confPassLabel.text = "Vuelva a escribir la contraseña."
        confPassLabel.textColor = .gray
        confPassTextField.layer.borderWidth = 0
        
        
        
        guard let mail = mail, let password = password, let confPassword = confPassword else {
            assertionFailure("No pueden ser nil")
            return false
        }
        
        if password.isEmpty && mail.isEmpty{
            
            mailLabel.text = tfError[0]
            mailLabel.textColor = .red
            mailTextField.layer.borderWidth = 1
            mailTextField.layer.borderColor = UIColor.red.cgColor
            passLabel.text = tfError[1]
            passLabel.textColor = .red
            passTextField.layer.borderWidth = 1
            passTextField.layer.borderColor = UIColor.red.cgColor
            flag = false
        }
        
        if confPassword.isEmpty || confPassword.count < 7 {
            confPassLabel.text = tfError[1]
            confPassLabel.textColor = .red
            confPassTextField.layer.borderWidth = 1
            confPassTextField.layer.borderColor = UIColor.red.cgColor
            flag = false
        }
        
        if !checkMailDomain(mail: mail) {
            mailLabel.text = tfError[0]
            mailLabel.textColor = .red
            mailTextField.layer.borderWidth = 1
            mailTextField.layer.borderColor = UIColor.red.cgColor
            flag = false
        }else {
            mailTextField.layer.borderWidth = 1
            mailTextField.layer.borderColor = UIColor.green.cgColor
        }
        
        if password != confPassword {
            confPassLabel.text = tfError[2]
            confPassLabel.textColor = .red
            confPassTextField.layer.borderWidth = 1
            confPassTextField.layer.borderColor = UIColor.red.cgColor
            flag = false
        } else {
            confPassLabel.text = tfError[3]
            confPassTextField.layer.borderWidth = 1
            confPassTextField.layer.borderColor = UIColor.red.cgColor
        }
        if password.count < 8 {
            passLabel.text = tfError[1]
            passLabel.textColor = .red
            passTextField.layer.borderWidth = 1
            passTextField.layer.borderColor = UIColor.red.cgColor
            flag = false
        }else {
            passTextField.layer.borderWidth = 1
            passTextField.layer.borderColor = UIColor.green.cgColor
        }
        return flag
    }
    
    func checkMailDomain(mail: String ) -> Bool {
        var substring = ""
        var flag = false
        for char in mail.lowercased() {
            if char == "@"{
                flag = true
            }
            if flag == true{
                substring.append(char)
            }
        }
        
        if substring != "@coppel.com" { return false}
        return true
    }
}
