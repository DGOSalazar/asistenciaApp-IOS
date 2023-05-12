//
//  BottomLineCustomTabBar.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 03/05/23.
//

import Foundation
import UIKit


internal protocol BottomLineCustomTabBarDelegate: AnyObject {
    func notifyBottomLineCustomTabBarTapped(tag: Int)
}


internal class BottomLineCustomTabBar: UIView {
    private var buttonsArray: [BottomLineCustomTabButton] = []
    internal weak var delegate: BottomLineCustomTabBarDelegate?
    private var currentIndex: Int = 0
    private var bottomBarWidthAnchor = NSLayoutConstraint()
    private var bottomBarCenterAnchor = NSLayoutConstraint()
    
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return view
    }()
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        return stack
    }()
    
    lazy var bottomBarIndicatorView: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
         return view
    }()
 
    
    internal init(titles: [String], selectedIndex: Int = 0, delegate: BottomLineCustomTabBarDelegate?) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        self.currentIndex = selectedIndex
        
        self.setComponents()
        self.setAutolayout()
        
        self.addButtons(titles: titles)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(buttonsStack)
        mainContainerView.addSubview(bottomBarIndicatorView)
    }
    
    private func setAutolayout() {
        bottomBarWidthAnchor = bottomBarIndicatorView.widthAnchor.constraint(equalToConstant: 0)
        bottomBarCenterAnchor = bottomBarIndicatorView.centerXAnchor.constraint(equalTo: buttonsStack.leadingAnchor)
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainContainerView.heightAnchor.constraint(equalToConstant: 54),
            
            buttonsStack.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 2),
            buttonsStack.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -2),
            
            bottomBarIndicatorView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            bottomBarIndicatorView.heightAnchor.constraint(equalToConstant: 5),
            bottomBarWidthAnchor,
            bottomBarCenterAnchor,
        ])
    }
    
    func addButtons(titles: [String], selectedIndex: Int = 0) {
        DispatchQueue.main.async {
            
            for index in 0 ..< titles.count {
                let auxButton = BottomLineCustomTabButton(title: titles[index], delegate: self)
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
            
            self.layoutIfNeeded()
        }
    }
    
    private func setButtonsStyle(tappedButton: BottomLineCustomTabButton) {
        currentIndex = tappedButton.tag
        self.isUserInteractionEnabled = false
        self.animateBottomBar(tappedButton: tappedButton)
        for button in buttonsArray {
            button.setStyle(selected: button == tappedButton)
        }
        self.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isUserInteractionEnabled = true
        }
    }
    
    private func animateBottomBar(tappedButton: BottomLineCustomTabButton) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.bottomBarCenterAnchor.constant = tappedButton.frame.midX
                self.bottomBarWidthAnchor.constant = tappedButton.frame.width
                self.layoutIfNeeded()
            }
        }
    }
}


extension BottomLineCustomTabBar: BottomLineCustomTabButtonDelegate {
    func notifyBottomLineCustomTabButtonTapped(button: BottomLineCustomTabButton) {
        guard button.tag != currentIndex else {
            return
        }

        setButtonsStyle(tappedButton: button)
        delegate?.notifyBottomLineCustomTabBarTapped(tag: button.tag)
    }
}
