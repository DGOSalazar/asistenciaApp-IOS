//
//  ConfirmationAlertView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 10/05/23.
//

import Foundation
import UIKit


internal class ConfirmationAlertView: UIViewController {
    internal var confirmCompletion: (() -> ())? = nil
    internal var cancelCompletion: (() -> ())? = nil
    
    
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
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return view
    }()
    
    lazy var contentLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoRegular(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var cancelButton: MainButton = {
       let button = MainButton(title: "Volver",
                               enable: true,
                               style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: MainButton = {
       let button = MainButton(title: "Confirmar",
                               enable: true,
                               style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.overrideWithFont = .robotoBold(ofSize: 18)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    required init(title: String, content: String, style: ConfirmationAlertStyleEnum) {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        
        setComponents()
        setAutolayout()
        
        titleLabel.text = title
        titleLabel.textColor = style.getFontColor()
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
        alertContainerView.addSubview(titleLabel)
        alertContainerView.addSubview(separatorLineView)
        alertContainerView.addSubview(contentLabel)
        alertContainerView.addSubview(cancelButton)
        alertContainerView.addSubview(confirmButton)
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
            
            alertIconImageView.centerYAnchor.constraint(equalTo: alertContainerView.topAnchor),
            alertIconImageView.centerXAnchor.constraint(equalTo: alertContainerView.centerXAnchor),
            alertIconImageView.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.25),
            alertIconImageView.heightAnchor.constraint(equalTo: alertIconImageView.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: alertIconImageView.bottomAnchor, constant: Dimensions.margin20),
            titleLabel.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            titleLabel.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
            
            separatorLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimensions.margin20),
            separatorLineView.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            separatorLineView.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            
            contentLabel.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: Dimensions.margin20),
            contentLabel.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            contentLabel.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
            
            cancelButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: Dimensions.margin20),
            cancelButton.trailingAnchor.constraint(equalTo: alertContainerView.centerXAnchor, constant: -Dimensions.margin5),
            cancelButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            cancelButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.4),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            confirmButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: Dimensions.margin20),
            confirmButton.leadingAnchor.constraint(equalTo: alertContainerView.centerXAnchor, constant: Dimensions.margin5),
            confirmButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            confirmButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.4),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true) {
            self.cancelCompletion?()
        }
    }
    
    @objc private func confirmButtonTapped() {
        self.dismiss(animated: true) {
            self.confirmCompletion?()
        }
    }
    
    
    internal func setCancelAction(title: String? = nil, completion: (() -> ())?) {
        if let nonNilTitle = title {
            self.cancelButton.setTitle(nonNilTitle, for: .normal)
        }
        
        self.cancelCompletion = completion
    }

    internal func setConfirmAction(title: String? = nil, completion: (() -> ())?) {
        if let nonNilTitle = title {
            self.confirmButton.setTitle(nonNilTitle, for: .normal)
        }
        
        self.confirmCompletion = completion
    }
}
