//
//  LoginViewController.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 14/02/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let logoAsistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoAsistencia")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let whiteBg: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let logoBancoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoBancoppelColored")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "¡Bienvenido!"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
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
    
    let passTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5

        return textField
    }()

    let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Olvidaste tu contraseña?"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "splashGradientBottom")
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Entrar", for: [])
        button.layer.cornerRadius = 30
        return button
    }()
    
    let newLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Eres Nuevo?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createAccLabel: UILabel = {
        let label = UILabel()
        label.text = "Crear una cuenta"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func loadView() {
        super.loadView()
        view = LoginBg()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autolayout()

    }
    

}
extension LoginViewController {
    func autolayout() {
        
        view.addSubview(logoAsistImageView)
        view.addSubview(whiteBg)
        view.addSubview(logoBancoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(mailTextField)
        view.addSubview(passTextField)
        view.addSubview(forgotLabel)
        view.addSubview(loginButton)
        view.addSubview(newLabel)
        view.addSubview(createAccLabel)
        
        NSLayoutConstraint.activate([
            
            logoAsistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            whiteBg.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            whiteBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoBancoImageView.centerYAnchor.constraint(equalTo: whiteBg.topAnchor, constant: 50),
            logoBancoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoBancoImageView.bottomAnchor, constant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mailTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            mailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailTextField.trailingAnchor, multiplier: 5),
            mailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            passTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 10),
            passTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passTextField.trailingAnchor, multiplier: 5),
            passTextField.heightAnchor.constraint(equalToConstant: 30),
           
            forgotLabel.topAnchor.constraint(equalToSystemSpacingBelow: passTextField.bottomAnchor, multiplier: 1),
            forgotLabel.trailingAnchor.constraint(equalTo: passTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotLabel.bottomAnchor, constant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            
            newLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50),
            newLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            
            createAccLabel.leadingAnchor.constraint(equalTo: newLabel.trailingAnchor, constant: 5),
            createAccLabel.bottomAnchor.constraint(equalTo: newLabel.bottomAnchor),
            
        ])
    }
}
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailTextField.endEditing(true)
        //passwordTextfield.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
