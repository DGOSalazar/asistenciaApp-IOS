//
//  TopNavigationBarView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 16/05/23.
//

import Foundation
import UIKit


internal class TopNavigationBarView: UIView {
    private var topLayoutGuide = UILayoutGuide()
    private var bankIconImageViewHeightConstraint = NSLayoutConstraint()
    private var backButtonWidthConstraint = NSLayoutConstraint()
    private var rightButtonWidthConstraint = NSLayoutConstraint()
    private var bankIconHeight: CGFloat = 15
    private var backButtonWidth: CGFloat = 30
    private var rightButtonWidth: CGFloat = 30
    private var backButtonAction: (() -> ())?
    private var rightButtonAction: (() -> ())?
    
    internal var showBankIcon: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.bankIconImageView.isHidden = !self.showBankIcon
                self.bankIconImageViewHeightConstraint.constant = self.showBankIcon ? self.bankIconHeight : 0
                self.layoutIfNeeded()
            }
        }
    }
    
    internal var showBackButton: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.backButton.isHidden = !self.showBackButton
                self.backButtonWidthConstraint.constant = self.showBackButton ? self.backButtonWidth : 0
            }
        }
    }
    
    internal var showRightButton: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.rightButton.isHidden = !self.showRightButton
                self.rightButtonWidthConstraint.constant = self.showRightButton ? self.rightButtonWidth : 0
            }
        }
    }
    
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(999), for: .vertical)
        return view
    }()
    
    private lazy var bankIconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "logo_bancoppel_blanco_gde")
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.isHidden = !showBankIcon
        icon.setContentCompressionResistancePriority(.init(999), for: .vertical)
        return icon
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        //button.setImage(UIImage(named: "left_arrow_icon"), for: .normal)
        button.isHidden = !showBackButton
        
        return button
    }()
    
    private lazy var backButtonIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "back_icon")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.setContentCompressionResistancePriority(.init(999), for: .vertical)
        return label
    }()
    
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "menu_login_white"), for: .normal)
        button.isHidden = !showRightButton
        return button
    }()
    
    
    internal init(title: String,
                  titleFont: UIFont = .robotoBold(ofSize: 20),
                  style: TopNavigationBarStylesEnum,
                  showBankIcon: Bool = false,
                  showBackButton: Bool = true,
                  showRightButton: Bool = false) {
        super.init(frame: .zero)
        
        setTitle(title: title)
        titleLabel.font = titleFont
        setStyle(style: style)
        self.showBankIcon = showBankIcon
        self.showBackButton = showBackButton
        self.showRightButton = showRightButton
        
        setComponents()
        setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(bankIconImageView)
        mainContainerView.addLayoutGuide(topLayoutGuide)
        mainContainerView.addSubview(backButton)
        backButton.addSubview(backButtonIcon)
        mainContainerView.addSubview(titleLabel)
        mainContainerView.addSubview(rightButton)
    }
    
    private func setAutolayout() {
        bankIconImageViewHeightConstraint = bankIconImageView.heightAnchor.constraint(equalToConstant: showBankIcon ? bankIconHeight : 0)
        backButtonWidthConstraint = backButton.widthAnchor.constraint(equalToConstant: showBackButton ? backButtonWidth : 0)
        rightButtonWidthConstraint = rightButton.widthAnchor.constraint(equalToConstant: showRightButton ? rightButtonWidth : 0)
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            bankIconImageView.topAnchor.constraint(equalTo: mainContainerView.safeAreaLayoutGuide.topAnchor),
            bankIconImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin25),
            bankIconImageViewHeightConstraint,
            bankIconImageView.widthAnchor.constraint(equalToConstant: 80),
            
            topLayoutGuide.topAnchor.constraint(equalTo: bankIconImageView.bottomAnchor, constant: Dimensions.margin30),
            topLayoutGuide.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin25),
            topLayoutGuide.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin25),
            topLayoutGuide.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -Dimensions.margin10),
            
            backButton.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: topLayoutGuide.leadingAnchor),
            backButton.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            backButtonWidthConstraint,
            
            backButtonIcon.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backButtonIcon.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            backButtonIcon.widthAnchor.constraint(equalTo: backButton.widthAnchor, multiplier: 0.5),
            backButtonIcon.heightAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 0.7),
            
            titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            
            rightButton.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: topLayoutGuide.trailingAnchor),
            rightButton.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            rightButtonWidthConstraint
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonAction?()
    }
    
    @objc private func rightButtonTapped() {
        rightButtonAction?()
    }
    
    internal func setStyle(style: TopNavigationBarStylesEnum) {
        DispatchQueue.main.async {
            self.bankIconImageView.tintColor = style.getBankIconColor()
            self.backButton.tintColor = style.getBackButtonColor()
            self.titleLabel.textColor = style.getTitleColor()
            self.rightButton.tintColor = style.getRightButtonColor()
        }
    }
    
    internal func setTitle(title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title.isEmpty ? " " : title
        }
    }
    
    internal func setBackButtonAction(action: (() -> ())?) {
        backButtonAction = action
    }
    
    internal func setRightButtonAction(action: (() -> ())?) {
        rightButtonAction = action
    }
}
