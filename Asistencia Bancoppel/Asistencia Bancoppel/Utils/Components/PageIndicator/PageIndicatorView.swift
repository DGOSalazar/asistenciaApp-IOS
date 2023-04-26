//
//  PageIndicatorView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 24/04/23.
//

import Foundation
import UIKit


internal protocol PageIndicatorViewDelegate: AnyObject {
    func notifyPageIndicatorViewTapped(index: Int)
}


internal class PageIndicatorView: UIView {
    internal weak var delegate: PageIndicatorViewDelegate?
    private var currentIndex: Int = 0
    private var dotSize: CGFloat = 12
    private var numberOfDots: Int = 3
    
    
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    lazy var itemsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    
    internal init(dotsSize: CGFloat = 12,
                  numberOfDots: Int = 3,
                  selectedIndex: Int,
                  filledDotColor: UIColor = GlobalConstants.BancoppelColors.blueBex7,
                  emptyDotColor: UIColor = GlobalConstants.BancoppelColors.grayBex2,
                  delegate: PageIndicatorViewDelegate?) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        self.currentIndex = selectedIndex
        self.dotSize = dotsSize
        self.numberOfDots = numberOfDots
        
        self.setComponents()
        self.setAutolayout()
        
        self.addButtons(number: numberOfDots, dotsSize: dotsSize, selectedIndex: selectedIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(itemsStack)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainContainerView.heightAnchor.constraint(equalToConstant: dotSize),
            
            itemsStack.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            itemsStack.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            itemsStack.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            itemsStack.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
        ])
    }
    
    private func addButtons(number: Int,
                            dotsSize: CGFloat = 12,
                            filledDotColor: UIColor = GlobalConstants.BancoppelColors.blueBex7,
                            emptyDotColor: UIColor = GlobalConstants.BancoppelColors.grayBex2,
                            selectedIndex: Int = 0) {
        DispatchQueue.main.async {
            for index in 0 ..< number {
                let auxItem = PageIndicatorItemView(itemSize: dotsSize,
                                                    filledDotColor: filledDotColor,
                                                    emptyDotColor: emptyDotColor,
                                                    delegate: self)
                auxItem.tag = index
                auxItem.translatesAutoresizingMaskIntoConstraints = false
                self.itemsStack.addArrangedSubview(auxItem)
                auxItem.setStyle(filled: index <= selectedIndex)
            }
        }
    }
}



extension PageIndicatorView: PageIndicatorItemViewDelegate {
    func notifyPageIndicatorItemViewTapped(index: Int) {
        delegate?.notifyPageIndicatorViewTapped(index: index)
    }
}



