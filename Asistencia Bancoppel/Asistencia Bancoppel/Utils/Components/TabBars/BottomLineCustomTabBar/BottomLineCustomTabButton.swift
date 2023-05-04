//
//  BottomLineCustomButton.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 03/05/23.
//

import Foundation
import UIKit

internal protocol BottomLineCustomTabButtonDelegate: AnyObject {
    func notifyBottomLineCustomTabButtonTapped(button: BottomLineCustomTabButton)
}


internal class BottomLineCustomTabButton: UIView {
    internal weak var delegate: BottomLineCustomTabButtonDelegate?
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        view.backgroundColor = .white
        return view
    }()
        
    private lazy var buttonTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    
    internal init(title: String,
                  delegate: BottomLineCustomTabButtonDelegate) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        buttonTitleLabel.text = title
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(buttonTitleLabel)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            buttonTitleLabel.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            buttonTitleLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin5),
            buttonTitleLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin5),
            buttonTitleLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
        ])
    }
    
    @objc func buttonTapped() {
        self.delegate?.notifyBottomLineCustomTabButtonTapped(button: self)
    }
    
    func setStyle(selected: Bool) {
        DispatchQueue.main.async {
            self.buttonTitleLabel.textColor = selected ? GlobalConstants.BancoppelColors.blueBex7 : GlobalConstants.BancoppelColors.grayBex5
        }
    }
}
