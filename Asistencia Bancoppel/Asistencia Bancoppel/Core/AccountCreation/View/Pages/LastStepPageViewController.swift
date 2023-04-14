//
//  LastStepPageViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import Foundation
import UIKit


internal protocol LastStepPageViewDelegate: AnyObject {
    func notifyLastStepPageFinish()
}


internal class LastStepPageViewController: UIViewController {
    internal weak var delegate: LastStepPageViewDelegate?
    
    
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¡Último paso!"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = Fonts.RobotoBold.of(size: 28)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var btFinish: MainButton = {
        let button = MainButton(title: "Finalizar", enable: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btNextPressed), for: .touchUpInside)
        return button
    }()
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setComponents()
        setAutolayout()
    }
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        
        vwContainer.addSubview(lbTitle)
        vwContainer.addSubview(btFinish)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            lbTitle.topAnchor.constraint(equalTo: vwContainer.topAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            
            btFinish.heightAnchor.constraint(equalToConstant: 59),
            btFinish.widthAnchor.constraint(equalToConstant: 200),
            btFinish.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btFinish.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor),
        ])
    }
    
    @objc private func btNextPressed() {
        delegate?.notifyLastStepPageFinish()
    }
}
