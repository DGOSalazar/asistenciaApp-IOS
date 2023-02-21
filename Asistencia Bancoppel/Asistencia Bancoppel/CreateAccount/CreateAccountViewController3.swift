//
//  CreateAccountViewController3.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 21/02/23.
//

import UIKit

class CreateAccountViewController3: UIViewController {
    
    let logoAsistView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lastStepLabel: UILabel = {
        let label = UILabel()
        label.text = "¡Ultimo Paso!"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Juan Ramon Rodriguez Gomez"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let uploadImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre: "
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let finishButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Finalizar", for: [])
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 22)
        button.layer.cornerRadius = 30
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("Cancelar", for: [])
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .primaryActionTriggered)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        autolayout()
    }
    
    @objc func nextButtonTapped(sender: UIButton) {
        if check(){
            self.view.window?.rootViewController?.dismiss(animated: true)
        }
    }
    
    @objc func cancelButtonTapped(){
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    func check() -> Bool {
        
        return true
    }
    
    
    func autolayout(){
        view.addSubview(logoAsistView)
        view.addSubview(lastStepLabel)
        view.addSubview(uploadImageView)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            logoAsistView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoAsistView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistView.heightAnchor.constraint(equalToConstant: 60),
            logoAsistView.widthAnchor.constraint(equalToConstant: 250),
            
            lastStepLabel.topAnchor.constraint(equalTo: logoAsistView.bottomAnchor, constant: 30),
            lastStepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            uploadImageView.heightAnchor.constraint(equalToConstant: 100),
            uploadImageView.widthAnchor.constraint(equalToConstant: 100),
            uploadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadImageView.topAnchor.constraint(equalTo: lastStepLabel.bottomAnchor, constant: 30),

            nameLabel.topAnchor.constraint(equalTo: uploadImageView.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    
}

