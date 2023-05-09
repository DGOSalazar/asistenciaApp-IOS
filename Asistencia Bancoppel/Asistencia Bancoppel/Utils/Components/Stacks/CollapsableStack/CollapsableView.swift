//
//  CollabsableStackView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 08/05/23.
//

import Foundation
import UIKit


internal protocol CollapsableViewDelegate: AnyObject {
    func notifyCollapsableViewAddElement(identifier: String)
}


internal class CollapsableView: UIView {
    internal weak var delegate: CollapsableViewDelegate?
    private var bottomContainerHeightConstraint: NSLayoutConstraint?
    internal var defaultSize: CGFloat = 150.0
    internal var collapsable: Bool = true
    internal var canUserAdd: Bool = true
    private var contentView: UIView = UIView()
    internal var identifier: String = ""
    private var collapsed: Bool = false
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoBold(ofSize: 20)
        return label
    }()
    
    internal lazy var collapseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        button.addTarget(self, action: #selector(collapseButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 4
        return button
    }()
    internal lazy var collapseIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "right_arrow_icon")
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.collapseButtonTapped))
        gesture.numberOfTapsRequired = 1
        icon.addGestureRecognizer(gesture)
        return icon
    }()
    
    internal lazy var addElementButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        button.layer.cornerRadius = 4
        return button
    }()

    private lazy var bottomContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomSeparatorView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return view
    }()
    
    internal init(title: String,
                  contentView: UIView,
                  collapsable: Bool,
                  canUserAdd: Bool,
                  identifier: String,
                  defaultSize: CGFloat = 150.0,
                  delegate: CollapsableViewDelegate?) {
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        self.contentView = contentView
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.collapsable = collapsable
        self.canUserAdd = canUserAdd
        self.identifier = identifier
        self.defaultSize = defaultSize
        self.collapsed = collapsable
        self.bottomSeparatorView.alpha = collapsable ? 1 : 0
        self.collapseButton.isHidden = !collapsable
        self.addElementButton.isHidden = !canUserAdd
        
        self.delegate = delegate
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(topContainerView)
        topContainerView.addSubview(titleLabel)
        topContainerView.addSubview(collapseButton)
        collapseButton.addSubview(collapseIcon)
        topContainerView.addSubview(addElementButton)
        
        mainContainerView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(contentView)
        
        mainContainerView.addSubview(bottomSeparatorView)
    }
    
    private func setAutolayout() {
        if self.collapsable {
            let contraint = bottomContainerView.heightAnchor.constraint(equalToConstant: 0)
            bottomContainerHeightConstraint = contraint
            NSLayoutConstraint.activate([
                contraint
            ])
        }
        
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            topContainerView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: Dimensions.margin10),
            titleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: collapseButton.leadingAnchor, constant: -Dimensions.margin5),
            titleLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -Dimensions.margin10),
            
            collapseButton.trailingAnchor.constraint(equalTo: addElementButton.leadingAnchor, constant: -Dimensions.margin5),
            collapseButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            collapseButton.heightAnchor.constraint(equalToConstant: 25),
            collapseButton.widthAnchor.constraint(equalToConstant: 25),
            
            collapseIcon.topAnchor.constraint(equalTo: collapseButton.topAnchor, constant: 5),
            collapseIcon.leadingAnchor.constraint(equalTo: collapseButton.leadingAnchor, constant: 5),
            collapseIcon.trailingAnchor.constraint(equalTo: collapseButton.trailingAnchor, constant: -5),
            collapseIcon.bottomAnchor.constraint(equalTo: collapseButton.bottomAnchor, constant: -5),
            
            addElementButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            addElementButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            addElementButton.heightAnchor.constraint(equalToConstant: 25),
            addElementButton.widthAnchor.constraint(equalToConstant: 25),
            

            bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            
            
            bottomSeparatorView.topAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    @objc func collapseButtonTapped() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                if let bottomHeightConstraint = self.bottomContainerHeightConstraint {
                    bottomHeightConstraint.constant = self.collapsed ? self.defaultSize : 0
                }
                
                self.bottomSeparatorView.alpha = self.collapsed ? 0 : 1
                
                self.collapseIcon.transform = self.collapseIcon.transform.rotated(by: self.collapsed ? (CGFloat.pi / 2) : (-CGFloat.pi / 2))
                
                self.superview?.layoutIfNeeded()
                self.superview?.superview?.layoutIfNeeded()
            }
            self.collapsed = !self.collapsed
        }
    }
    
    @objc func addButtonTapped() {
        delegate?.notifyCollapsableViewAddElement(identifier: identifier)
    }
}
