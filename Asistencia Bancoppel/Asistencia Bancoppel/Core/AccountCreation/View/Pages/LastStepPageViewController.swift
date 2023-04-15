//
//  LastStepPageViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import Foundation
import UIKit

struct Charge {
    var title: String
    var id: Int
}

struct Initiative {
    var title: String
    var id: Int
}


internal protocol LastStepPageViewDelegate: AnyObject {
    func notifyLastStepPageFinish()
}


internal class LastStepPageViewController: UIViewController {
    internal weak var delegate: LastStepPageViewDelegate?
    private var charges: [Charge] = [Charge(title: "Tester/QA", id: 0),
                                     Charge(title: "Developer", id: 1),
                                     Charge(title: "Project Manager", id: 2),
                                     Charge(title: "Scrum Master", id: 3),
                                     Charge(title: "Manager", id: 4)]
    
    private var initiatives: [Initiative] = [Initiative(title: "Tester/QA2", id: 0),
                                             Initiative(title: "Developer2", id: 1),
                                             Initiative(title: "Project Manager2", id: 2),
                                             Initiative(title: "Scrum Master2", id: 3),
                                             Initiative(title: "Manager2", id: 4)]
    
    
    
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
    
    
    lazy var vwContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwDataContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var txtfCharge: GenericPickerTextField = {
        let titles = charges.map { $0.title }
        let textField = GenericPickerTextField(title: "Puesto:",
                                               placeholder: "Selecciona una opción",
                                               dataTitles: titles,
                                               data: charges,
                                               delegate: self,
                                               identifier: "charge")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var txtfInitiative: GenericPickerTextField = {
        let titles = initiatives.map { $0.title }
        
        let textField = GenericPickerTextField(title: "Iniciativa:",
                                               placeholder: "Selecciona una opción",
                                               dataTitles: titles,
                                               data: initiatives,
                                               delegate: self,
                                               identifier: "initative")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var txtfColaboratorNumber: LeftTitleTextField = {
        let textField = LeftTitleTextField(title: "Nº de Colaborador:",
                                           placeholder: "",
                                           delegate: self,
                                           identifier: "colaboratorNumber")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        vwContainer.addSubview(vwContent)
        
        vwContent.addSubview(vwDataContainer)
        vwDataContainer.addSubview(txtfCharge)
        vwDataContainer.addSubview(txtfInitiative)
        vwDataContainer.addSubview(txtfColaboratorNumber)
        
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
            
            vwContent.topAnchor.constraint(equalTo: lbTitle.bottomAnchor),
            vwContent.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 20),
            vwContent.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -20),
            vwContent.bottomAnchor.constraint(equalTo: btFinish.topAnchor),
            
            vwDataContainer.topAnchor.constraint(greaterThanOrEqualTo: vwContent.topAnchor),
            vwDataContainer.centerYAnchor.constraint(equalTo: vwContent.centerYAnchor),
            vwDataContainer.leadingAnchor.constraint(equalTo: vwContent.leadingAnchor),
            vwDataContainer.trailingAnchor.constraint(equalTo: vwContent.trailingAnchor),
            vwDataContainer.bottomAnchor.constraint(lessThanOrEqualTo: vwContent.bottomAnchor),
            
            txtfCharge.topAnchor.constraint(equalTo: vwDataContainer.topAnchor),
            txtfCharge.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfCharge.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfInitiative.topAnchor.constraint(equalTo: txtfCharge.bottomAnchor, constant: 20),
            txtfInitiative.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfInitiative.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfColaboratorNumber.topAnchor.constraint(equalTo: txtfInitiative.bottomAnchor, constant: 20),
            txtfColaboratorNumber.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfColaboratorNumber.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            txtfColaboratorNumber.bottomAnchor.constraint(equalTo: vwDataContainer.bottomAnchor),
            
            btFinish.heightAnchor.constraint(equalToConstant: 59),
            btFinish.widthAnchor.constraint(equalToConstant: 200),
            btFinish.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btFinish.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func btNextPressed() {
        delegate?.notifyLastStepPageFinish()
    }
}


extension LastStepPageViewController: LeftTitleTextFieldDelegate {
    func leftTitleTextFieldDidChange(identifier: String, text: String) {
        print("\(identifier): \(text)")
    }
}



extension LastStepPageViewController: GenericPickerTextFieldDelegate {
    func genericPickerTextFieldDone(identifier: String) {
        print("\(identifier)")
    }
    
    func genericPickerTextFieldDidChange<T>(identifier: String, data: T?) {
        if identifier == txtfCharge.identifier {
            print("\(identifier): \((data as? Charge)?.title)")
        } else if identifier == txtfInitiative.identifier {
            print("\(identifier): \((data as? Initiative)?.title)")
        }
    }
}
