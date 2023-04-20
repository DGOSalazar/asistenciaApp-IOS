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
    func notifyLastStepPageFinish(charge: String, team: String, collaboratorNumber: Int, photo: UIImage)
    func notifyGetUsername() -> String
}


internal class LastStepPageViewController: UIViewController {
    internal weak var delegate: LastStepPageViewDelegate?
    private var profilePhoto: UIImage?
    internal var userName: String = ""
    
    private var charges: [Charge] = [Charge(title: "Tester/QA", id: 0),
                                     Charge(title: "Android Dev", id: 1),
                                     Charge(title: "IOS Dev", id: 2),
                                     Charge(title: "Backend Dev", id: 3),
                                     Charge(title: "Scrum Master", id: 4),
                                     Charge(title: "Business Analyst", id: 5),
                                     Charge(title: "Otro", id: 6)]
    
    private var initiatives: [Initiative] = [Initiative(title: "Alpha", id: 0),
                                             Initiative(title: "Beta", id: 1),
                                             Initiative(title: "Gamma", id: 2),
                                             Initiative(title: "Delta", id: 3),
                                             Initiative(title: "Epsilon", id: 4),
                                             Initiative(title: "Otro", id: 5)]
    
    
    
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
        label.font = .robotoBold(ofSize: 28)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var vwContent: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwDataContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var btLoadPhoto: UploadPhotoButton = {
        let button = UploadPhotoButton(presenter: self, delegate: self)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var lbUserName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 18)
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
        textField.textFont = .robotoMedium(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.inputValidation = .numeric
        textField.maxLength = 8
        textField.textAlignment = .right
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbUserName.text = delegate?.notifyGetUsername() ?? ""
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
            
            vwContent.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 20),
            vwContent.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 20),
            vwContent.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -20),
            vwContent.bottomAnchor.constraint(equalTo: btFinish.topAnchor, constant: -20),
            
            vwDataContainer.topAnchor.constraint(equalTo: vwContent.topAnchor),
            vwDataContainer.leadingAnchor.constraint(equalTo: vwContent.leadingAnchor),
            vwDataContainer.trailingAnchor.constraint(equalTo: vwContent.trailingAnchor),
            vwDataContainer.bottomAnchor.constraint(equalTo: vwContent.bottomAnchor),
            vwDataContainer.widthAnchor.constraint(equalTo: vwContent.widthAnchor),
            
            
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
        guard validateData() else {
            return
        }
        
        delegate?.notifyLastStepPageFinish(charge: txtfCharge.getGenericValue()?.title ?? "",
                                           team: txtfInitiative.getGenericValue()?.title ?? "",
                                           collaboratorNumber: Int(txtfColaboratorNumber.getText()) ?? 0,
                                           photo: profilePhoto ?? UIImage())
    }
    
    @objc private func btUploadPhotoPressed() {
    }
    
    private func validatePhoto() -> Bool {
        return profilePhoto != nil
    }
    
    private func validateCharge() -> Bool {
        let charge = txtfCharge.getGenericValue()
        return (charge != nil && (charge?.title.isEmpty == false))
    }
    
    private func validateInitiative() -> Bool {
        let team = txtfInitiative.getGenericValue()
        return (team != nil && (team?.title.isEmpty == false))
    }
    
    private func validateCollaboratorNumber() -> Bool {
        let collaboratorNumber = txtfColaboratorNumber.getText()
        guard let _ = Int(collaboratorNumber), !collaboratorNumber.isEmpty else {
            return false
        }
        return true
    }
    
    private func validateData() -> Bool {
        let isValidCharge = validateCharge()
        let isValidInitiative = validateInitiative()
        let isValidCollaboratorNumer = validateCollaboratorNumber()
        let isValidPhoto = validatePhoto()
        return (isValidCharge && isValidInitiative && isValidCollaboratorNumer && isValidPhoto)
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

extension LastStepPageViewController: UploadPhotoButtonDelegate {
    func notifyPhotoSelected(photo: UIImage) {
        profilePhoto = photo
    }
}
