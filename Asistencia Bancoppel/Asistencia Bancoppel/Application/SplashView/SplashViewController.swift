//
//  SplashViewController.swift
//  Asistencia Bancoppel
//
//  Created by Joel Ramírez on 11/04/23.
//


import UIKit
//import FirebaseAnalytics

class SplashViewController: UIViewController {

    let centerLogoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let logoAsistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoAsistencia")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let colorbarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "colorbar")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let logoBancoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoBancoppel")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func loadView() {
        super.loadView()
        view = GradientBackgroundView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        autolayout()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //Logica para cambio de vista
        //Timer Provisional
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            let navigationController = UINavigationController(rootViewController: LoginViewController())
            navigationController.isNavigationBarHidden = true
            self.view.window?.rootViewController = navigationController
        }
    }
}
extension SplashViewController {

    func autolayout() {
        
        centerLogoStackView.addArrangedSubview(logoAsistImageView)
        centerLogoStackView.addArrangedSubview(colorbarImageView)
        view.addSubview(centerLogoStackView)
        view.addSubview(logoBancoImageView)
        NSLayoutConstraint.activate([
            
            centerLogoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLogoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
        
            logoBancoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            logoBancoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

