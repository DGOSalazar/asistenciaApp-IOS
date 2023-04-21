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
        stackView.spacing = 50
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
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let mailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Correo Electronico"
        textField.font = .robotoItalic(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .secondarySystemBackground
        } else {
            print("Not aviable version of iOS")
        }
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let passTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.font = .robotoItalic(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            textField.backgroundColor = .secondarySystemBackground
        } else {
          print("Not aviable version of iOS")
        }
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5

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
    
    let loginButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "splashGradientBottom")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 22)
        button.setTitle("Entrar", for: [])
        button.layer.cornerRadius = 30
        button.addTarget(nil, action: #selector(loginTapped), for: .touchUpInside)
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
           // self.succesLoged = loged ?? false
           // DispatchQueue.main.async {
            if loged == true {
                let mainViewController = MainPagerViewController()
                mainViewController.email = self.mailTextField.text ?? ""
                self.navigationController?.pushViewController(mainViewController, animated: true)
            } else {
                let alerta = UIAlertController(title: "Credenciales incorrectas", message: "Por favor, ingrese las credenciales correctas.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alerta.addAction(okAction)
                self.present(alerta, animated: true, completion: nil)
            }
                
            //}
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
            logoAsistImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            blueAlphaBG.topAnchor.constraint(equalTo: view.topAnchor),
            blueAlphaBG.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blueAlphaBG.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueAlphaBG.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            whiteBg.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            whiteBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteBg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            welcomeStackView.topAnchor.constraint(equalTo: whiteBg.topAnchor, constant: 50),
            welcomeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            passTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passTextField.trailingAnchor, multiplier: 5),
            passTextField.heightAnchor.constraint(equalToConstant: 30),

            mailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mailTextField.trailingAnchor, multiplier: 5),
            mailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            
            createAccStackView.topAnchor.constraint(equalTo: welcomeStackView.bottomAnchor, constant: 20),
            createAccStackView.centerXAnchor.constraint(equalTo: whiteBg.centerXAnchor),
            
            
        ])
    }
    
    @objc func createAccTapped(_ gesture: UITapGestureRecognizer) {
        let createAccVC = AccountCreationViewController()
        self.present(createAccVC, animated: true)
    }
    
    @objc func loginTapped() {
        CustomLoader.show()
        guard let mail = mailTextField.text,
              let pass = passTextField.text else {
            CustomLoader.hide()
            print("Ingresar las credenciales correctas...")
            return
        }
        viewModel.makeLogin(email: mail, credential: pass)
    }
}
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailTextField.endEditing(true)
        passTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

