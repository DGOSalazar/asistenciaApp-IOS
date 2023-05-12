//
//  ProfileCertificationAlertView.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 11/05/23.
//

import Foundation
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers


protocol ProfileCertificationAlertDelegate: AnyObject {
    func notifyProfileCertificationConfirm(data: ProfileCertificationsModel.Certification)
}


internal class ProfileCertificationAlertView: UIViewController {
    internal var delegate: ProfileCertificationAlertDelegate?
    private var document: String?
    private var modelData = ProfileCertificationsModel.Certification()
    
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex10.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var alertContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var topContentStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = Dimensions.margin20
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Agregar certificación"
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoBold(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Ingresa los datos del certificado"
        return label
    }()
    
    
    lazy var middleContentStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var certificateNameTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
                                            placeholder: "Nombre",
                                            delegate: self,
                                            identifier: "certificateName")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputValidation = .spaAlphanumeric
        textField.maxLength = 40
        return textField
    }()
    
    lazy var certificateEmissionDateTextField: DatePickerTextField = {
       let textField = DatePickerTextField(title: "",
                                           placeholder: "Fecha de emisión",
                                           delegate: self,
                                           identifier: "certificateEmissionDate",
                                           minimumDate: Calendar.current.date(byAdding: .year, value: -100, to: Date()),
                                           maximumDate: Date())
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var certificateEmissorTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
                                            placeholder: "Emitido por",
                                            delegate: self,
                                            identifier: "certificateEmissor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputValidation = .spaAlphanumeric
        textField.maxLength = 40
        return textField
    }()
    
    lazy var certificateNumberTextField: BottomTitleTextField = {
       let textField = BottomTitleTextField(title: "",
                                            placeholder: "Número de certificado",
                                            delegate: self,
                                            identifier: "certificateNumber")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.inputValidation = .numeric
        textField.maxLength = 20
        return textField
    }()
    
    
    lazy var bottomContentStack: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = Dimensions.margin20
        return view
    }()
    
    lazy var certificateNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.font = .robotoBold(ofSize: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = ""
        label.isHidden = true
        return label
    }()
    
    lazy var addCertificateFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Agregar certificado", for: .normal)
        button.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addCertificateButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .robotoBold(ofSize: 14)
        return button
    }()
    
    
    private lazy var cancelButton: MainButton = {
       let button = MainButton(title: "Volver",
                               enable: true,
                               style: .secondary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: MainButton = {
       let button = MainButton(title: "Confirmar",
                               enable: false,
                               style: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.overrideWithFont = .robotoBold(ofSize: 18)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    required init(delegate: ProfileCertificationAlertDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        
        self.delegate = delegate
        
        setComponents()
        setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
    }
    

    private func setComponents() {
        self.view.addSubview(mainContainerView)
        mainContainerView.addSubview(backgroundView)
        mainContainerView.addSubview(alertContainerView)
        
        alertContainerView.addSubview(topContentStack)
        topContentStack.addArrangedSubview(titleLabel)
        topContentStack.addArrangedSubview(separatorLineView)
        topContentStack.addArrangedSubview(subtitleLabel)
        
        alertContainerView.addSubview(middleContentStack)
        middleContentStack.addArrangedSubview(certificateNameTextField)
        middleContentStack.addArrangedSubview(certificateEmissionDateTextField)
        middleContentStack.addArrangedSubview(certificateEmissorTextField)
        middleContentStack.addArrangedSubview(certificateNumberTextField)
        
        alertContainerView.addSubview(bottomContentStack)
        bottomContentStack.addArrangedSubview(certificateNameLabel)
        bottomContentStack.addArrangedSubview(addCertificateFileButton)
        
        alertContainerView.addSubview(cancelButton)
        alertContainerView.addSubview(confirmButton)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            alertContainerView.topAnchor.constraint(greaterThanOrEqualTo: mainContainerView.safeAreaLayoutGuide.topAnchor, constant: Dimensions.margin20),
            alertContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin20),
            alertContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin20),
            alertContainerView.bottomAnchor.constraint(lessThanOrEqualTo: mainContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin20),
            alertContainerView.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            
            
            
            topContentStack.topAnchor.constraint(equalTo: alertContainerView.topAnchor, constant: Dimensions.margin20),
            topContentStack.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            topContentStack.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
 
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            
            
            middleContentStack.topAnchor.constraint(equalTo: topContentStack.bottomAnchor, constant: Dimensions.margin20),
            middleContentStack.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            middleContentStack.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
  
            
            bottomContentStack.topAnchor.constraint(equalTo: middleContentStack.bottomAnchor),
            bottomContentStack.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: Dimensions.margin20),
            bottomContentStack.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -Dimensions.margin20),
            
            
            
            cancelButton.topAnchor.constraint(equalTo: bottomContentStack.bottomAnchor, constant: Dimensions.margin20),
            cancelButton.trailingAnchor.constraint(equalTo: alertContainerView.centerXAnchor, constant: -Dimensions.margin5),
            cancelButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            cancelButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.4),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            confirmButton.topAnchor.constraint(equalTo: bottomContentStack.bottomAnchor, constant: Dimensions.margin20),
            confirmButton.leadingAnchor.constraint(equalTo: alertContainerView.centerXAnchor, constant: Dimensions.margin5),
            confirmButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -Dimensions.margin20),
            confirmButton.widthAnchor.constraint(equalTo: alertContainerView.widthAnchor, multiplier: 0.4),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    
    @objc private func addCertificateButtonTapped() {
        let pdfPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        pdfPicker.delegate = self
        pdfPicker.allowsMultipleSelection = false
        self.present(pdfPicker, animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func confirmButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.notifyProfileCertificationConfirm(data: self.modelData)
        }
    }
    
    private func setCertificate(url: URL) {
        DispatchQueue.main.async {
            guard url.startAccessingSecurityScopedResource() else {
                return
            }
            
            guard let nonNilDocumentData = try? Data(contentsOf: url.absoluteURL) else {
                return
            }
            
            self.document = nonNilDocumentData.base64EncodedString()
            
            let attributedName = NSMutableAttributedString()
            attributedName.append("Certificado: ".attributed(color: GlobalConstants.BancoppelColors.grayBex10,
                                                             font: .robotoBold(ofSize: 14)))
            
            attributedName.append(url.lastPathComponent.attributed(color: GlobalConstants.BancoppelColors.grayBex10,
                                                                   font: .robotoRegular(ofSize: 14)))
            
            UIView.animate(withDuration: 0.2) {
                self.certificateNameLabel.attributedText = attributedName
                self.certificateNameLabel.isHidden = false
                self.addCertificateFileButton.setTitle("Cambiar certificado", for: .normal)
        
                self.view.layoutIfNeeded()
            }
            
            url.stopAccessingSecurityScopedResource()
            
            self.validateData()
        }
    }
    
    private func validateName() -> Bool {
        let name = certificateNameTextField.getText()
        guard !name.isEmpty else {
            return false
        }
    
        modelData.certificateName = name
        return true
    }
    
    private func validateEmissionDate() -> Bool {
        let date = certificateEmissionDateTextField.getText()
        guard !date.isEmpty else {
            return false
        }
    
        modelData.emissionDate = date
        return true
    }
    
    private func validateEmissor() -> Bool {
        let emissor = certificateEmissorTextField.getText()
        guard !emissor.isEmpty else {
            return false
        }
    
        modelData.platformEmitted = emissor
        return true
    }
    
    private func validateNumber() -> Bool {
        let number = certificateNumberTextField.getText()
        guard !number.isEmpty else {
            return false
        }
    
        modelData.certificateNum = number
        return true
    }
    
    private func validateCertificate() -> Bool {
        guard let certificate = self.document, !certificate.isEmpty else {
            return false
        }
    
        modelData.resourcePdf = certificate
        return true
    }
    
    private func validateData() {
        self.confirmButton.setStatus(enable: (validateName() &&
                                              validateEmissionDate() &&
                                              validateEmissor() &&
                                              validateNumber() &&
                                              validateCertificate()))
    }
}

extension ProfileCertificationAlertView: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        
        setCertificate(url: url)
    }
}


extension ProfileCertificationAlertView: BottomTitleTextFieldDelegate {
    func bottomTitleTextFieldDidChange(identifier: String, text: String) {
        validateData()
    }
    func bottomTitleTextFieldDone(identifier: String) {
        if identifier == certificateNameTextField.identifier {
            _ = certificateEmissionDateTextField.becomeFirstResponder()
        } else if identifier == certificateEmissorTextField.identifier {
            _ = certificateNumberTextField.becomeFirstResponder()
        } else if identifier == certificateNumberTextField.identifier {
            _ = certificateNumberTextField.resignFirstResponder()
        }
    }
}


extension ProfileCertificationAlertView: DatePickerTextFieldDelegate {
    func datePickerTextFieldDidChange(identifier: String, text: String){
        validateData()
    }
    
    func datePickerTextFieldDone(identifier: String) {
        _ = certificateEmissorTextField.becomeFirstResponder()
    }
}
