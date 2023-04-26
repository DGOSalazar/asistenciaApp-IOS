//
//  PageIndicatorItemView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 24/04/23.
//

import Foundation
import UIKit


internal protocol PageIndicatorItemViewDelegate: AnyObject {
    func notifyPageIndicatorItemViewTapped(index: Int)
}


internal class PageIndicatorItemView: UIView {
    internal weak var delegate: PageIndicatorItemViewDelegate?
    private var itemSize: CGFloat = 12
    private var filledDotColor: UIColor = GlobalConstants.BancoppelColors.blueBex7
    private var emptyDotColor: UIColor = GlobalConstants.BancoppelColors.grayBex2


    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.itemTapped))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    

    internal init(itemSize: CGFloat = 12,
                  filledDotColor: UIColor = GlobalConstants.BancoppelColors.blueBex7,
                  emptyDotColor: UIColor = GlobalConstants.BancoppelColors.grayBex2,
                  delegate: PageIndicatorItemViewDelegate?) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        self.itemSize = itemSize
        self.filledDotColor = filledDotColor
        self.emptyDotColor = emptyDotColor
        self.mainContainerView.layer.cornerRadius = (itemSize/2.0)
        
        self.setComponents()
        self.setAutolayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainContainerView.heightAnchor.constraint(equalToConstant: itemSize),
            mainContainerView.widthAnchor.constraint(equalToConstant: itemSize),
        ])
    }
    
    @objc func itemTapped() {
        delegate?.notifyPageIndicatorItemViewTapped(index: self.tag)
    }
    
    internal func setStyle(filled: Bool) {
        DispatchQueue.main.async {
            self.mainContainerView.backgroundColor = filled ? self.filledDotColor : self.emptyDotColor
            self.mainContainerView.layer.cornerRadius = (self.itemSize/2.0)
        }
    }
}

