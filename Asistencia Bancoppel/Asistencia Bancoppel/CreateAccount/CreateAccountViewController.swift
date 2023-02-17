//
//  CreateAccountViewController.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 14/02/23.
//

import UIKit

// MARK: CreateAccount 1st View
class CreateAccountViewController1: UIViewController {
    
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
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let mailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Correo Electronico"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let mailLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingresa tu correo Coppel."
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5

        return textField
    }()
    
    let passLabel: UILabel = {
        let label = UILabel()
        label.text = "Debe contener 8 caracteres."
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let confPassTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirmar contraseña"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5

        return textField
    }()
    
    let confPassLabel: UILabel = {
        let label = UILabel()
        label.text = "Vuelva a escribir la contraseña."
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Siguiente", for: [])
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        autolayout()
    }
    
    func autolayout() {
        
        view.addSubview(logoAsistView)
        view.addSubview(createTitleLabel)
        view.addSubview(mailTextField)
        view.addSubview(mailLabel)
        view.addSubview(passTextField)
        view.addSubview(passLabel)
        view.addSubview(confPassTextField)
        view.addSubview(confPassLabel)
        view.addSubview(nextButton)
        
        
        NSLayoutConstraint.activate([
            logoAsistView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoAsistView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistView.heightAnchor.constraint(equalToConstant: 60),
            logoAsistView.widthAnchor.constraint(equalToConstant: 250),
            
            createTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createTitleLabel.topAnchor.constraint(equalTo: logoAsistView.bottomAnchor, constant: 90),
            
            mailTextField.topAnchor.constraint(equalTo: createTitleLabel.bottomAnchor, constant: 50),
            mailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailTextField.trailingAnchor, multiplier: 5),
            mailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            mailLabel.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 3),
            mailLabel.trailingAnchor.constraint(equalTo: mailTextField.trailingAnchor),
            
            passTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 40),
            passTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passTextField.trailingAnchor, multiplier: 5),
            passTextField.heightAnchor.constraint(equalToConstant: 30),
            
            passLabel.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 3),
            passLabel.trailingAnchor.constraint(equalTo: passTextField.trailingAnchor),
            
            confPassTextField.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 40),
            confPassTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: confPassTextField.trailingAnchor, multiplier: 5),
            confPassTextField.heightAnchor.constraint(equalToConstant: 30),
            
            confPassLabel.topAnchor.constraint(equalTo: confPassTextField.bottomAnchor, constant: 3),
            confPassLabel.trailingAnchor.constraint(equalTo: confPassTextField.trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: confPassTextField.bottomAnchor, constant: 100),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            
        ])
        
        
        
    }
}
// MARK: CreateAccount 2nd View

class CreateAccountViewController2: UIViewController {
    
    let logoAsistView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let personalDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Datos Personales"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre: "
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apellidos: "
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Fecha de nacimiento: "
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "dd/mm/aaaa"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Numero celular: "
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let nextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Siguiente", for: [])
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        autolayout()
    }
    
    func autolayout() {
        
        view.addSubview(logoAsistView)
        view.addSubview(personalDataLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameTextField)
        view.addSubview(birthDateLabel)
        view.addSubview(birthDateTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        
        
        NSLayoutConstraint.activate([
            logoAsistView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoAsistView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistView.heightAnchor.constraint(equalToConstant: 60),
            logoAsistView.widthAnchor.constraint(equalToConstant: 250),
            
            personalDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personalDataLabel.topAnchor.constraint(equalTo: logoAsistView.bottomAnchor, constant: 90),
            
            nameLabel.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),
            
            nameTextField.topAnchor.constraint(equalTo: personalDataLabel.bottomAnchor, constant: 50),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nameTextField.trailingAnchor, multiplier: 5),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            lastNameLabel.centerYAnchor.constraint(equalTo: lastNameTextField.centerYAnchor),
            lastNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            lastNameLabel.widthAnchor.constraint(equalToConstant: 70),
            
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: lastNameTextField.trailingAnchor, multiplier: 5),
            lastNameTextField.leadingAnchor.constraint(equalTo: lastNameLabel.trailingAnchor),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            birthDateLabel.centerYAnchor.constraint(equalTo: birthDateTextField.centerYAnchor),
            birthDateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            birthDateLabel.widthAnchor.constraint(equalToConstant: 160),
            
            birthDateTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: birthDateTextField.trailingAnchor, multiplier: 5),
            birthDateTextField.leadingAnchor.constraint(equalTo: birthDateLabel.trailingAnchor),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 30),
            
            phoneLabel.centerYAnchor.constraint(equalTo: phoneTextField.centerYAnchor),
            phoneLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            phoneLabel.widthAnchor.constraint(equalToConstant: 110),
            
            phoneTextField.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: phoneTextField.trailingAnchor, multiplier: 5),
            phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30),
            
            nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            
        ])
        
        
        
    }
}
