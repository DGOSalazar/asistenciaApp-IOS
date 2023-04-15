//
//  PersonalDataPageViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import Foundation
import UIKit

internal protocol PersonalDataPageDelegate: AnyObject {
    func notifyPersonalDataNext()
}


internal class PersonalDataPageViewController: UIViewController {
    internal weak var delegate: PersonalDataPageDelegate?
    
    
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Datos personales"
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
    
    lazy var txtfName: LeftTitleTextField = {
       let textField = LeftTitleTextField(title: "Nombre: ",
                                            placeholder: "",
                                            delegate: self,
                                            identifier: "name")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var txtfLastnames: LeftTitleTextField = {
       let textField = LeftTitleTextField(title: "Apellidos:",
                                            placeholder: "",
                                            delegate: self,
                                            identifier: "lastnames")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var txtfBirthDate: DatePickerTextField = {
       let textField = DatePickerTextField(title: "Fecha de nacimiento:",
                                            placeholder: "dd/mm/aaaa",
                                            delegate: self,
                                            identifier: "birthDate")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var txtfCellphone: LeftTitleTextField = {
       let textField = LeftTitleTextField(title: "Número celular:",
                                            placeholder: "",
                                            delegate: self,
                                            identifier: "cellphone")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var btNext: MainButton = {
        let button = MainButton(title: "Siguiente", enable: true)
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
        vwDataContainer.addSubview(txtfName)
        vwDataContainer.addSubview(txtfLastnames)
        vwDataContainer.addSubview(txtfBirthDate)
        vwDataContainer.addSubview(txtfCellphone)
        
        vwContainer.addSubview(btNext)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            lbTitle.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 50),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            
            vwContent.topAnchor.constraint(equalTo: lbTitle.bottomAnchor),
            vwContent.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 20),
            vwContent.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -20),
            vwContent.bottomAnchor.constraint(equalTo: btNext.topAnchor),
            
            vwDataContainer.topAnchor.constraint(greaterThanOrEqualTo: vwContent.topAnchor),
            vwDataContainer.centerYAnchor.constraint(equalTo: vwContent.centerYAnchor),
            vwDataContainer.leadingAnchor.constraint(equalTo: vwContent.leadingAnchor),
            vwDataContainer.trailingAnchor.constraint(equalTo: vwContent.trailingAnchor),
            vwDataContainer.bottomAnchor.constraint(lessThanOrEqualTo: vwContent.bottomAnchor),
            
            txtfName.topAnchor.constraint(equalTo: vwDataContainer.topAnchor),
            txtfName.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfName.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfLastnames.topAnchor.constraint(equalTo: txtfName.bottomAnchor),
            txtfLastnames.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfLastnames.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfBirthDate.topAnchor.constraint(equalTo: txtfLastnames.bottomAnchor),
            txtfBirthDate.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfBirthDate.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfCellphone.topAnchor.constraint(equalTo: txtfBirthDate.bottomAnchor),
            txtfCellphone.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfCellphone.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            txtfCellphone.bottomAnchor.constraint(equalTo: vwDataContainer.bottomAnchor),
            
            
            btNext.heightAnchor.constraint(equalToConstant: 59),
            btNext.widthAnchor.constraint(equalToConstant: 200),
            btNext.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btNext.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func btNextPressed() {
        delegate?.notifyPersonalDataNext()
    }
}


extension PersonalDataPageViewController: LeftTitleTextFieldDelegate {
    func leftTitleTextFieldDidChange(identifier: String, text: String) {
        print("\(identifier): \(text)")
    }
}

extension PersonalDataPageViewController: DatePickerTextFieldDelegate {
    func datePickerTextFieldDidChange(identifier: String, text: String) {
        print("\(identifier): \(text)")
    }
}



