//
//  UploadPhotoButton.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 15/04/23.
//

import Foundation
import UIKit


internal class UploadPhotoButton: UIView {
    private var buttonSize: CGFloat = 99
    
    private lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    private lazy var ivwIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = GlobalConstants.BancoppelColors.blueBex7
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    private lazy var lbTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.RobotoRegular.of(size: 15)
        label.textColor = GlobalConstants.BancoppelColors.grayBex4
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(999), for: .vertical)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    internal init(buttonSize: CGFloat = 140,
                  title: String = "Cargar foto",
                  icon: UIImage? = nil,
                  borderColor: UIColor = GlobalConstants.BancoppelColors.yellowBex3) {
        super.init(frame: .zero)
        
        self.buttonSize = buttonSize
        self.lbTitle.text = title
        self.ivwIcon.image = icon ?? UIImage(named: "share_media_icon")
        self.vwContainer.layer.borderColor = borderColor.cgColor
        self.vwContainer.layer.cornerRadius = (buttonSize / 2)
        
        
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(vwContainer)
        
        vwContainer.addSubview(ivwIcon)
        vwContainer.addSubview(lbTitle)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.topAnchor),
            vwContainer.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            vwContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vwContainer.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            vwContainer.heightAnchor.constraint(equalToConstant: self.buttonSize),
            vwContainer.widthAnchor.constraint(equalToConstant: self.buttonSize),
            
            ivwIcon.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 20),
            ivwIcon.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 20),
            ivwIcon.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -20),
            
            lbTitle.topAnchor.constraint(equalTo: ivwIcon.bottomAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 20),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -20),
            lbTitle.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -30),
        ])
    }
    
    internal func addTarget(_ target: Any?, action: Selector?) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
    }
}
