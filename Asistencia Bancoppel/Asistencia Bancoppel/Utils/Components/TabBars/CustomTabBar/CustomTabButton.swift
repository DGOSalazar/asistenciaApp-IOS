//
//  CustomTabButton.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 21/04/23.
//

import Foundation
import UIKit

internal protocol CustomTabButtonDelegate: AnyObject {
    func notifyCustomTabButtonTapped(button: CustomTabButton)
}


internal class CustomTabButton: UIView {
    private var buttonModel: CustomTabButtonModel?
    internal weak var delegate: CustomTabButtonDelegate?
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        
        return view
    }()
        
    private lazy var elementsContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private lazy var buttonTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(999), for: .vertical)
        return label
    }()
    
    
    internal init(buttonModel: CustomTabButtonModel, delegate: CustomTabButtonDelegate) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        self.buttonModel = buttonModel
        buttonTitleLabel.text = buttonModel.title
        
        self.mainContainerView.layer.shadowOffset = buttonModel.shadowStyle.getShadowOffset()
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(elementsContainer)
        elementsContainer.addSubview(iconImageView)
        elementsContainer.addSubview(buttonTitleLabel)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            elementsContainer.topAnchor.constraint(greaterThanOrEqualTo: mainContainerView.topAnchor),
            elementsContainer.leadingAnchor.constraint(greaterThanOrEqualTo: mainContainerView.leadingAnchor),
            elementsContainer.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            elementsContainer.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            elementsContainer.trailingAnchor.constraint(lessThanOrEqualTo: mainContainerView.trailingAnchor),
            elementsContainer.bottomAnchor.constraint(lessThanOrEqualTo: mainContainerView.bottomAnchor),
            
            
            iconImageView.topAnchor.constraint(equalTo: elementsContainer.topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: elementsContainer.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.3),
            iconImageView.widthAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.4),
            
            buttonTitleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            buttonTitleLabel.leadingAnchor.constraint(equalTo: elementsContainer.leadingAnchor),
            buttonTitleLabel.trailingAnchor.constraint(equalTo: elementsContainer.trailingAnchor),
            buttonTitleLabel.bottomAnchor.constraint(equalTo: elementsContainer.bottomAnchor),
        ])
    }
    
    @objc func buttonTapped() {
        self.delegate?.notifyCustomTabButtonTapped(button: self)
    }
    
    func setStyle(selected: Bool) {
        DispatchQueue.main.async {
            self.superview?.layoutIfNeeded()
            self.mainContainerView.layer.cornerRadius = selected ? (self.mainContainerView.bounds.height / 2.0) : 0.0
            self.mainContainerView.backgroundColor = selected ? .white : .clear
            self.mainContainerView.layer.shadowColor = selected ? UIColor.black.cgColor : UIColor.clear.cgColor
            self.iconImageView.image = selected ? self.buttonModel?.selectedIcon : self.buttonModel?.unselectedIcon
            self.buttonTitleLabel.font = selected ? .robotoBold(ofSize: 12) : .robotoRegular(ofSize: 12)
            self.superview?.layoutIfNeeded()
        }
    }
}
