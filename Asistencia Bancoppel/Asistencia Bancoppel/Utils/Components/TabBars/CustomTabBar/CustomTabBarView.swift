//
//  CustomTabBarView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 21/04/23.
//

import Foundation
import UIKit


internal protocol CustomTabBarViewDelegate: AnyObject {
    func notifyCustomTabBarButtonTapped(tag: Int)
}


internal class CustomTabBarView: UIView {
    private var buttonsArray: [CustomTabButton] = []
    internal weak var delegate: CustomTabBarViewDelegate?
    private var currentIndex: Int = 0
    
    
    private lazy var shadowContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        return view
    }()
    

    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
 
    
    internal init(buttons: [CustomTabButtonModel], selectedIndex: Int = 0, delegate: CustomTabBarViewDelegate?) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        self.currentIndex = selectedIndex
        
        self.setComponents()
        self.setAutolayout()
        
        self.addButtons(buttons: buttons)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(shadowContainer)
        shadowContainer.addSubview(mainContainerView)
        mainContainerView.addSubview(buttonsStack)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            shadowContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: -5),
            shadowContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            shadowContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shadowContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            shadowContainer.heightAnchor.constraint(equalToConstant: 70),
            
            mainContainerView.topAnchor.constraint(greaterThanOrEqualTo: shadowContainer.topAnchor, constant: 5),
            mainContainerView.leadingAnchor.constraint(equalTo: shadowContainer.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: shadowContainer.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: shadowContainer.bottomAnchor),
            
            buttonsStack.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -5),
        ])
    }
    
    func addButtons(buttons: [CustomTabButtonModel], selectedIndex: Int = 0) {
        DispatchQueue.main.async {
            
            
            for index in 0 ..< buttons.count {
                let auxButton = CustomTabButton(buttonModel: buttons[index], delegate: self)
                auxButton.translatesAutoresizingMaskIntoConstraints = false
                self.buttonsArray.append(auxButton)
                self.buttonsStack.addArrangedSubview(auxButton)
                auxButton.setStyle(selected: false)
            }
            
            self.currentIndex = (selectedIndex < self.buttonsArray.count && selectedIndex >= 0) ? selectedIndex : 0
            
            for index in 0 ..< self.buttonsArray.count {
                self.buttonsArray[index].tag = index
            }
            
            guard self.currentIndex < self.buttonsArray.count, self.currentIndex >= 0 else {
                return
            }
            
            self.setButtonsStyle(tappedButton: self.buttonsArray[self.currentIndex])
        }
    }
    
    private func setButtonsStyle(tappedButton: CustomTabButton) {
        currentIndex = tappedButton.tag
        self.isUserInteractionEnabled = false
        for button in buttonsArray {
            button.setStyle(selected: button == tappedButton)
        }
        self.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isUserInteractionEnabled = true
        }
    }
}


extension CustomTabBarView: CustomTabButtonDelegate {
    func notifyCustomTabButtonTapped(button: CustomTabButton) {
        guard button.tag != currentIndex else {
            return
        }

        setButtonsStyle(tappedButton: button)
        delegate?.notifyCustomTabBarButtonTapped(tag: button.tag)
    }
}
