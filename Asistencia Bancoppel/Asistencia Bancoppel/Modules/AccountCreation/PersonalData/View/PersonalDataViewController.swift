//
//  PersonalDataViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 24/04/23.
//

import Foundation
import UIKit


internal class PersonalDataViewController: UIViewController {
    var model = AccountCreationModel()
    var credential: String = ""
    private var firstLastname: String = ""
    private var secondLastname: String = ""
    
    
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ivwLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoCoppelAsistenciaColored")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Datos personales"
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.font = .robotoBold(ofSize: 28)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    
    lazy var vwContainerScroll: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwContentContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vwDataContainerStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        //view.spacing = Dimensions.margin20
        return view
    }()
    
    lazy var txtfName: LeftTitleTextField = {
       let textField = LeftTitleTextField(title: "Nombre: ",
                                            placeholder: "",
                                            delegate: self,
                                            identifier: "name",
                                          casing: .capitalized)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputValidation = .spaAlphabetic
        textField.maxLength = 40
        return textField
    }()
    
    lazy var txtfLastnames: LeftTitleTextField = {
       let textField = LeftTitleTextField(title: "Apellidos:",
                                            placeholder: "",
                                            delegate: self,
                                            identifier: "lastnames",
                                          casing: .capitalized)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputValidation = .spaAlphabetic
        textField.maxLength = 40
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
        textField.inputValidation = .numeric
        textField.keyboardType = .phonePad
        textField.maxLength = 10
        return textField
    }()
    
    lazy var btNext: MainButton = {
        let button = MainButton(title: "Siguiente", enable: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btNextPressed), for: .touchUpInside)
        return button
    }()
    
    
    lazy var pageIndicatorView: PageIndicatorView = {
       let view = PageIndicatorView(selectedIndex: 1, delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        vwContainer.addSubview(ivwLogo)
        vwContainer.addSubview(lbTitle)
        
        
        vwContainer.addSubview(vwContainerScroll)
        vwContainerScroll.addSubview(vwContentContainer)
        vwContentContainer.addSubview(vwDataContainerStack)
        vwDataContainerStack.addArrangedSubview(txtfName)
        vwDataContainerStack.addArrangedSubview(txtfLastnames)
        vwDataContainerStack.addArrangedSubview(txtfBirthDate)
        vwDataContainerStack.addArrangedSubview(txtfCellphone)

        vwContainer.addSubview(btNext)
        vwContainer.addSubview(pageIndicatorView)
    }
    
    private func setAutolayout() {
        let contentHeightAnchor = vwContentContainer.heightAnchor.constraint(equalTo: vwContainerScroll.heightAnchor)
        contentHeightAnchor.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ivwLogo.topAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.topAnchor, constant: Dimensions.margin40),
            ivwLogo.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin80),
            ivwLogo.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin80),
            ivwLogo.heightAnchor.constraint(equalToConstant: (50 * DeviceSize.size.getMultiplier())),
            
            lbTitle.topAnchor.constraint(equalTo: ivwLogo.bottomAnchor, constant: Dimensions.margin60),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            
            vwContainerScroll.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: Dimensions.margin40),
            vwContainerScroll.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin40),
            vwContainerScroll.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin40),
            vwContainerScroll.bottomAnchor.constraint(equalTo: btNext.topAnchor, constant: -Dimensions.margin40),
            
            
            vwContentContainer.topAnchor.constraint(equalTo: vwContainerScroll.topAnchor),
            vwContentContainer.leadingAnchor.constraint(equalTo: vwContainerScroll.leadingAnchor),
            vwContentContainer.trailingAnchor.constraint(equalTo: vwContainerScroll.trailingAnchor),
            vwContentContainer.bottomAnchor.constraint(equalTo: vwContainerScroll.bottomAnchor),
            vwContentContainer.widthAnchor.constraint(equalTo: vwContainerScroll.widthAnchor),
            contentHeightAnchor,
            
            vwDataContainerStack.topAnchor.constraint(greaterThanOrEqualTo: vwContentContainer.topAnchor),
            vwDataContainerStack.leadingAnchor.constraint(equalTo: vwContentContainer.leadingAnchor),
            vwDataContainerStack.trailingAnchor.constraint(equalTo: vwContentContainer.trailingAnchor),
            vwDataContainerStack.bottomAnchor.constraint(lessThanOrEqualTo: vwContentContainer.bottomAnchor),
            vwDataContainerStack.centerYAnchor.constraint(equalTo: vwContentContainer.centerYAnchor),
            
            
            
            btNext.heightAnchor.constraint(equalToConstant: 59),
            btNext.widthAnchor.constraint(equalTo: vwContainer.widthAnchor, multiplier: 0.6),
            btNext.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btNext.bottomAnchor.constraint(equalTo: pageIndicatorView.topAnchor, constant: -Dimensions.margin40),
            
            
            pageIndicatorView.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            pageIndicatorView.bottomAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin40),
        ])
    }
    
    @objc private func btNextPressed() {
        
        guard validateData() else {
            return
        }
        
        let viewController = LastStepViewController()
        viewController.model = self.model
        viewController.model.name = txtfName.getText()
        viewController.model.lastName1 = firstLastname
        viewController.model.lastName2 = secondLastname
        viewController.model.birthDay = txtfBirthDate.getText()
        viewController.model.phone = txtfCellphone.getText()
        viewController.credential = credential
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func validateName() -> Bool {
        guard !txtfName.getText().isEmpty else {
            txtfName.setDefaultStatus()
            return false
        }
        
        txtfName.setSuccessStatus()
        return true
    }
    
    private func validateLastname() -> Bool {
        let lastnames = txtfLastnames.getText()
        let auxLastnames = lastnames.split(separator: " ")
 
        guard !lastnames.isEmpty, auxLastnames.count <= 2 else {
            txtfLastnames.setDefaultStatus()
            return false
        }
        
        if auxLastnames.count == 2 {
            firstLastname = String(auxLastnames.first ?? "")
            secondLastname = String(auxLastnames.last ?? "")
        } else {
            firstLastname = lastnames
            secondLastname = ""
        }
        
        txtfLastnames.setSuccessStatus()
        return true
    }
    
    private func validateBirthDate() -> Bool {
        guard !txtfBirthDate.getText().isEmpty else {
            txtfBirthDate.setDefaultStatus()
            return false
        }
        
        txtfBirthDate.setSuccessStatus()
        return true
    }
    
    private func validatePhoneNumber() -> Bool {
        let cellphone = txtfCellphone.getText()
        
        guard !cellphone.isEmpty else {
            txtfCellphone.setDefaultStatus()
            return false
        }
        
        guard cellphone.isPhoneNumber() else {
            txtfCellphone.setFailureStatus(message: "Número inválido.")
            return false
        }
        
        txtfCellphone.setSuccessStatus()
        return true
    }
    
    private func validateData() -> Bool {
        let isValidName = validateName()
        let isValidLastname = validateLastname()
        let isValidBirthDate = validateBirthDate()
        let isValidPhoneNumber = validatePhoneNumber()
        return (isValidName && isValidLastname && isValidBirthDate && isValidPhoneNumber)
    }
}


extension PersonalDataViewController: LeftTitleTextFieldDelegate {
    func leftTitleTextFieldDidChange(identifier: String, text: String) {
        btNext.setStatus(enable: validateData())
    }
    
    func leftTitleTextFieldDone(identifier: String) {
        if identifier == txtfName.identifier {
            _ = txtfLastnames.becomeFirstResponder()
        } else if identifier == txtfLastnames.identifier {
            _ = txtfBirthDate.becomeFirstResponder()
        } else if identifier == txtfCellphone.identifier {
            _ = txtfCellphone.resignFirstResponder()
        }
    }
}

extension PersonalDataViewController: DatePickerTextFieldDelegate {
    func datePickerTextFieldDidChange(identifier: String, text: String) {
        btNext.setStatus(enable: validateData())
    }
    func datePickerTextFieldDone(identifier: String) {
        _ = txtfCellphone.becomeFirstResponder()
    }
}


extension PersonalDataViewController: PageIndicatorViewDelegate {
    func notifyPageIndicatorViewTapped(index: Int) {
        print(index)
    }
}



