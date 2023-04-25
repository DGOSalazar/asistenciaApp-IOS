//
//  LoginViewController.swift
//  Asistencia Bancoppel
//
//  Created by Joel Ramirez on 12/04/23.
//

import UIKit
//import FirebaseAnalytics

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    private var succesLoged = false
    
    let logoAsistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoAsistencia")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let blueAlphaBG: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "splashGradientBottom")?.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let whiteBg: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let welcomeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Dimensions.margin40
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Dimensions.margin20
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mailTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
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
    
    lazy var passTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
                                            placeholder: "Contraseña",
                                            delegate: self,
                                            identifier: "credential",
                                            isSecure: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.allowSpaces = false
        textField.maxLength = 40
        return textField
    }()
    

    let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Olvidaste tu contraseña?"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var loginButton: MainButton = {
        let button = MainButton(title: "Entrar", enable: true)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    let createAccStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .bottom
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let newLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Eres Nuevo?"
        label.textAlignment = .center
        label.font = .robotoRegular(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createAccLabel: UILabel = {
        let label = UILabel()
        label.text = "Crear una cuenta"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func loadView() {
        super.loadView()
        view = LoginBackgroundView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.delegate = self
        passTextField.delegate = self
      //  Analytics.logEvent("SplashScreen", parameters: ["message": "Integracion de Firebase completa"])
        autolayout()
        makeCreateAccClickeable()
        bind()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func makeCreateAccClickeable() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createAccTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        createAccLabel.isUserInteractionEnabled = true
        createAccLabel.addGestureRecognizer(tapGesture)
    }
    
    
    private func bind() {
        self.viewModel.loginObservable.observe = { loged in
            CustomLoader.hide()
            if loged == true {
                let mainViewController = MainPagerViewController()
                mainViewController.email = self.mailTextField.getText()
                self.navigationController?.pushViewController(mainViewController, animated: true)
            } else {
                let alerta = UIAlertController(title: "Credenciales incorrectas", message: "Por favor, ingrese las credenciales correctas.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alerta.addAction(okAction)
                self.present(alerta, animated: true, completion: nil)
            }
        }
    }

}
extension LoginViewController {
    func autolayout() {
        dataStackView.addArrangedSubview(mailTextField)
        dataStackView.addArrangedSubview(passTextField)
        dataStackView.addArrangedSubview(forgotLabel)
        
        welcomeStackView.addArrangedSubview(logoBancoImageView)
        welcomeStackView.addArrangedSubview(welcomeLabel)
        welcomeStackView.addArrangedSubview(dataStackView)
        welcomeStackView.addArrangedSubview(loginButton)
        
        createAccStackView.addArrangedSubview(newLabel)
        createAccStackView.addArrangedSubview(createAccLabel)
        
        view.addSubview(blueAlphaBG)
        view.addSubview(logoAsistImageView)
        view.addSubview(whiteBg)
        view.addSubview(welcomeStackView)
        view.addSubview(createAccStackView)
        
        
        NSLayoutConstraint.activate([
            
            logoAsistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Dimensions.margin150),
            
            blueAlphaBG.topAnchor.constraint(equalTo: view.topAnchor),
            blueAlphaBG.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blueAlphaBG.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueAlphaBG.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            whiteBg.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            whiteBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            welcomeStackView.topAnchor.constraint(equalTo: whiteBg.topAnchor, constant: Dimensions.margin50),
            welcomeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            passTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passTextField.trailingAnchor, multiplier: 5),
            mailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailTextField.trailingAnchor, multiplier: 5),
            
            loginButton.heightAnchor.constraint(equalToConstant: 59),
            loginButton.widthAnchor.constraint(equalTo: welcomeStackView.widthAnchor, multiplier: 0.6),
            
            createAccStackView.topAnchor.constraint(equalTo: welcomeStackView.bottomAnchor, constant: Dimensions.margin20),
            createAccStackView.centerXAnchor.constraint(equalTo: whiteBg.centerXAnchor),
            createAccStackView.bottomAnchor.constraint(equalTo: whiteBg.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin20),
        ])
    }
    
    @objc func createAccTapped(_ gesture: UITapGestureRecognizer) {
        let createAccVC = AccountCreationViewController()
        self.navigationController?.pushViewController(createAccVC, animated: true)
    }
    
    @objc func loginTapped() {
        guard validateData() else {
            return
        }
        CustomLoader.show()
        viewModel.makeLogin(email: mailTextField.getText().lowercased(), credential: passTextField.getText())
    }
    
    private func validateData() -> Bool {
        let isValidEmail = validateEmail()
        let isValidCredential = validatedCredential()
        return (isValidEmail && isValidCredential)
    }
    
    private func validateEmail() -> Bool {
        let email = mailTextField.getText().lowercased()
        guard !email.isEmpty, email.contains("@") else {
            mailTextField.setDefaultStatus()
            return false
        }
        
        guard email.isCoppelEmail() else {
            mailTextField.setFailureStatus(message: "Ingresa un correo Coppel válido.")
            return false
        }

        mailTextField.setDefaultStatus()
        return true
    }
    
    private func validatedCredential() -> Bool {
        let credential = passTextField.getText()
        
        guard !credential.isEmpty else {
            passTextField.setDefaultStatus()
            return false
        }
        
        guard credential.count >= 8 else {
            passTextField.setFailureStatus(message: "Ingresa una contraseña válida (al menos 8 caracteres).")
            return false
        }
        
        passTextField.setDefaultStatus()
        return true
    }
}

extension LoginViewController: BottomTitleTextFieldDelegate {
    func bottomTitleTextFieldDidChange(identifier: String, text: String) {
        
    }
    
    
    func bottomTitleTextFieldDone(identifier: String) {
        if identifier == mailTextField.identifier {
            _ = passTextField.becomeFirstResponder()
        } else if identifier == passTextField.identifier {
            _ = passTextField.resignFirstResponder()
        }
    }
    
}

