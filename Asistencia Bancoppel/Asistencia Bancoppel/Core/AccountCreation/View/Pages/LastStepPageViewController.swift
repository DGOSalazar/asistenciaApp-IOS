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
    
    lazy var btLoadPhoto: UploadPhotoButton = {
        let button = UploadPhotoButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btUploadPhotoPressed))
        return button
    }()
    
    lazy var lbUserName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Héctor González Martínez"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = Fonts.RobotoBold.of(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var txtfCharge: GenericPickerTextField = {
        let titles = charges.map { $0.title }
        let textField = GenericPickerTextField(title: "Puesto:",
                                               placeholder: "Selecciona una opción",
                                               dataTitles: titles,
                                               genericData: charges,
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
                                               genericData: initiatives,
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
        self.hideKeyboardWhenTapped()
        setComponents()
        setAutolayout()
    }
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        
        vwContainer.addSubview(lbTitle)
        vwContainer.addSubview(vwContent)
        
        vwContent.addSubview(vwDataContainer)
        vwDataContainer.addSubview(btLoadPhoto)
        vwDataContainer.addSubview(lbUserName)
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
            
            
            btLoadPhoto.topAnchor.constraint(equalTo: vwDataContainer.topAnchor),
            btLoadPhoto.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            btLoadPhoto.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            lbUserName.topAnchor.constraint(equalTo: btLoadPhoto.bottomAnchor, constant: 30),
            lbUserName.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            lbUserName.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfCharge.topAnchor.constraint(equalTo: lbUserName.bottomAnchor, constant: 30),
            txtfCharge.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfCharge.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfInitiative.topAnchor.constraint(equalTo: txtfCharge.bottomAnchor),
            txtfInitiative.leadingAnchor.constraint(equalTo: vwDataContainer.leadingAnchor),
            txtfInitiative.trailingAnchor.constraint(equalTo: vwDataContainer.trailingAnchor),
            
            txtfColaboratorNumber.topAnchor.constraint(equalTo: txtfInitiative.bottomAnchor),
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
    
    @objc private func btUploadPhotoPressed() {
    }
    
    private func validateCharge() -> Bool {
        return (txtfCharge.getGenericValue() != nil)
    }
    
    private func validateInitiative() -> Bool {
        return (txtfInitiative.getGenericValue() != nil)
    }
    
    private func validateCollaboratorNumber() -> Bool {
        return !txtfColaboratorNumber.getText().isEmpty
    }
    
    private func validateData() -> Bool {
        let isValidCharge = validateCharge()
        let isValidInitiative = validateInitiative()
        let isValidCollaboratorNumer = validateCollaboratorNumber()
        return (isValidCharge && isValidInitiative && isValidCollaboratorNumer)
    }
}


extension LastStepPageViewController: LeftTitleTextFieldDelegate {
    func leftTitleTextFieldDidChange(identifier: String, text: String) {
        btFinish.setStatus(enable: validateData())
    }
}



extension LastStepPageViewController: GenericPickerTextFieldDelegate {
    func genericPickerTextFieldDone(identifier: String) {
        if identifier == txtfCharge.identifier {
            _ = txtfInitiative.becomeFirstResponder()
        } else if identifier == txtfInitiative.identifier {
            _ = txtfColaboratorNumber.becomeFirstResponder()
        } else if identifier == txtfColaboratorNumber.identifier {
            _ = txtfColaboratorNumber.resignFirstResponder()
        }
    }
    
    func genericPickerTextFieldDidChange<T>(identifier: String, data: T?) {
        btFinish.setStatus(enable: validateData())
    }
}
