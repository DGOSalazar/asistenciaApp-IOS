//
//  LastStepViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 24/04/23.
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


internal class LastStepViewController: UIViewController {
    private let viewModel = LastStepViewModel()
    var model = AccountCreationModel()
    private var profilePhoto: UIImage?
    var credential: String = ""
    
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
        label.text = "¡Último paso!"
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
        return view
    }()
    
    

    
    lazy var btLoadPhoto: UploadPhotoButton = {
        let button = UploadPhotoButton(presenter: self,
                                       delegate: self,
                                       buttonSize: (140.0 * DeviceSize.size.getMultiplier()))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var usernameContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.text = ((model.name ?? "") + " " + (model.lastName1 ?? "") + " " + (model.lastName2 ?? ""))
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

    
    
    lazy var pagerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTapped()
        
        setComponents()
        setAutolayout()
        
        bind()
    }
    
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        vwContainer.addSubview(ivwLogo)
        vwContainer.addSubview(lbTitle)
        
        vwContainer.addSubview(vwContainerScroll)
        vwContainerScroll.addSubview(vwContentContainer)
        vwContentContainer.addSubview(vwDataContainerStack)
        vwDataContainerStack.addArrangedSubview(btLoadPhoto)
        
        vwDataContainerStack.addArrangedSubview(usernameContainerView)
        usernameContainerView.addSubview(lbUserName)
        
        vwDataContainerStack.addArrangedSubview(txtfCharge)
        vwDataContainerStack.addArrangedSubview(txtfInitiative)
        vwDataContainerStack.addArrangedSubview(txtfColaboratorNumber)
        
        vwContainer.addSubview(btFinish)
        vwContainer.addSubview(pagerView)
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
            
            lbTitle.topAnchor.constraint(equalTo: ivwLogo.bottomAnchor, constant: Dimensions.margin30),
            lbTitle.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            
            vwContainerScroll.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: Dimensions.margin30),
            vwContainerScroll.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin40),
            vwContainerScroll.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin40),
            vwContainerScroll.bottomAnchor.constraint(equalTo: btFinish.topAnchor, constant: -Dimensions.margin30),
            
            
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
            
            
            
            lbUserName.topAnchor.constraint(equalTo: usernameContainerView.topAnchor, constant: Dimensions.margin20),
            lbUserName.leadingAnchor.constraint(equalTo: usernameContainerView.leadingAnchor),
            lbUserName.trailingAnchor.constraint(equalTo: usernameContainerView.trailingAnchor),
            lbUserName.bottomAnchor.constraint(equalTo: usernameContainerView.bottomAnchor, constant: -Dimensions.margin20),
            

            
            btFinish.heightAnchor.constraint(equalToConstant: 59),
            btFinish.widthAnchor.constraint(equalTo: vwContainer.widthAnchor, multiplier: 0.6),
            btFinish.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btFinish.bottomAnchor.constraint(equalTo: pagerView.topAnchor, constant: -Dimensions.margin40),
            
            
            
            pagerView.heightAnchor.constraint(equalToConstant: 30),
            pagerView.widthAnchor.constraint(equalToConstant: 80),
            pagerView.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            pagerView.bottomAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin40),
        ])
    }
    
    @objc private func btNextPressed() {
        guard validateData() else {
            return
        }
        
        CustomLoader.show()
        
        model.position = txtfCharge.getGenericValue()?.title ?? ""
        model.team = txtfInitiative.getGenericValue()?.title ?? ""
        model.employee = Int(txtfColaboratorNumber.getText()) ?? 0
        
        viewModel.registerAccount(accountRequest: model,
                                  credential: credential,
                                  photo: profilePhoto ?? UIImage())
    }
    
    
    private func bind(){
        self.viewModel.accountCreationObaservable.observe = { errorMessage in
            CustomLoader.hide()

            guard let nonNilErrorMessage = errorMessage else {
                self.showAlert(message: "Cuenta creada con éxito.")
                return
            }
            
            self.showAlert(message: nonNilErrorMessage ?? "", isError: true)
        }
    }
    
    private func showAlert(message: String, isError: Bool = false) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: isError ? "Error" : "Información",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                guard !isError else {
                    return
                }
                let viewController = MainPagerViewController()
                viewController.email = self.model.email ?? ""
                self.navigationController?.pushViewController(viewController, animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
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


extension LastStepViewController: LeftTitleTextFieldDelegate {
    func leftTitleTextFieldDidChange(identifier: String, text: String) {
        btFinish.setStatus(enable: validateData())
    }
}



extension LastStepViewController: GenericPickerTextFieldDelegate {
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

extension LastStepViewController: UploadPhotoButtonDelegate {
    func notifyPhotoSelected(photo: UIImage) {
        profilePhoto = photo
        btFinish.setStatus(enable: validateData())
    }
}
