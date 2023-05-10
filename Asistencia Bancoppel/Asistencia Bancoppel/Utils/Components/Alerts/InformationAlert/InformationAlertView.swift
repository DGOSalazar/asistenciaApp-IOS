//
//  InformationAlert.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 10/05/23.
//

import Foundation
import UIKit


internal class InformationAlertView: UIViewController {
    internal var completion: (() -> ())? = nil
    
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex10.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var alertContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var alertIconImageView: UIImageView = {
       let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    lazy var contentLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoMedium(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var actionButton: MainButton = {
       let button = MainButton(title: "Aceptar",
                               enable: true,
                               style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    required init(content: String, style: InformationAlertStyleEnum) {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        
        setComponents()
        setAutolayout()
        
        contentLabel.text = content
        alertIconImageView.image = style.getIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setComponents() {
        self.view.addSubview(mainContainerView)
        mainContainerView.addSubview(backgroundView)
        mainContainerView.addSubview(alertContainerView)
        
        alertContainerView.addSubview(alertIconImageView)
        alertContainerView.addSubview(contentLabel)
        alertContainerView.addSubview(actionButton)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            alertContainerView.topAnchor.constraint(greaterThanOrEqualTo: mainContainerView.safeAreaLayoutGuide.topAnchor, constant: Dimensions.margin20),
            alertContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin20),
            alertContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin20),
            alertContainerView.bottomAnchor.constraint(lessThanOrEqualTo: mainContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin20),
            alertContainerView.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            
            alertIconImageView.topAnchor.constraint(equalTo: alertContainerView.topAnchor, constant: Dimensions.margin20),
            alertIconImageView.centerXAnchor.constraint(equalTo: alertContainerView.centerXAnchor),
            alertIconImageView.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.25),
            alertIconImageView.heightAnchor.constraint(equalTo: alertIconImageView.widthAnchor),
            
            
            contentLabel.topAnchor.constraint(equalTo: alertIconImageView.bottomAnchor, constant: Dimensions.margin20),
            contentLabel.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            contentLabel.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
            
            
            actionButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: Dimensions.margin20),
            actionButton.centerXAnchor.constraint(equalTo: alertContainerView.centerXAnchor),
            actionButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            actionButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.6),
            actionButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    internal func setAction(title: String? = nil, completion: (() -> ())?) {
        if let nonNilTitle = title {
            self.actionButton.setTitle(nonNilTitle, for: .normal)
        }
        
        self.completion = completion
    }
    
    
    @objc private func actionButtonTapped() {
        self.dismiss(animated: true) {
            self.completion?()
        }
    }
}
