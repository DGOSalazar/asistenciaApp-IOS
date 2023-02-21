//
//  CreateAccountViewController2.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 21/02/23.
//

import UIKit

class CreateAccountViewController2: UIViewController {
    
    var name: String? {
        return nameTextField.text
    }
    var lastName: String? {
        return lastNameTextField.text
    }
    var birthDate: String? {
        return birthDateTextField.text
    }
    var phone: String? {
        return phoneTextField.text
    }
    
    
    let logoAsistView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let personalDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Datos Personales"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre: "
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Roboto-Regular", size: 12)
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apellidos: "
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Roboto-Regular", size: 12)
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Fecha de nacimiento: "
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemBackground
        let maxDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(valueChanged(datePicker:)), for: .valueChanged)
        return datePicker
    }()
    
    let birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "dd/mm/aaaa"
        textField.font = UIFont(name: "Roboto-Italic", size: 12)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemBackground
        textField.textAlignment = .center
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Numero celular: "
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Roboto-Regular", size: 12)
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let nextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Siguiente", for: [])
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 22)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
        button.layer.cornerRadius = 30
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("Cancelar", for: [])
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        phoneTextField.delegate = self
        autolayout()
        birthDateTextField.inputView = birthDatePicker
    }
    
// MARK: CreateAccountVC2 Autolayout
    func autolayout() {
        
        view.addSubview(logoAsistView)
        view.addSubview(personalDataLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameTextField)
        view.addSubview(birthDateLabel)
        view.addSubview(birthDateTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        view.addSubview(cancelButton)

        
        
        NSLayoutConstraint.activate([
            logoAsistView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoAsistView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistView.heightAnchor.constraint(equalToConstant: 60),
            logoAsistView.widthAnchor.constraint(equalToConstant: 250),
            
            personalDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personalDataLabel.topAnchor.constraint(equalTo: logoAsistView.bottomAnchor, constant: 90),
            
            nameLabel.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),
            
            nameTextField.topAnchor.constraint(equalTo: personalDataLabel.bottomAnchor, constant: 50),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nameTextField.trailingAnchor, multiplier: 5),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            lastNameLabel.centerYAnchor.constraint(equalTo: lastNameTextField.centerYAnchor),
            lastNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            lastNameLabel.widthAnchor.constraint(equalToConstant: 70),
            
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: lastNameTextField.trailingAnchor, multiplier: 5),
            lastNameTextField.leadingAnchor.constraint(equalTo: lastNameLabel.trailingAnchor),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            birthDateLabel.centerYAnchor.constraint(equalTo: birthDateTextField.centerYAnchor),
            birthDateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            birthDateLabel.widthAnchor.constraint(equalToConstant: 160),
            
            birthDateTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: birthDateTextField.trailingAnchor, multiplier: 5),
            birthDateTextField.leadingAnchor.constraint(equalTo: birthDateLabel.trailingAnchor),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 30),
            
            phoneLabel.centerYAnchor.constraint(equalTo: phoneTextField.centerYAnchor),
            phoneLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            phoneLabel.widthAnchor.constraint(equalToConstant: 110),
            
            phoneTextField.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: phoneTextField.trailingAnchor, multiplier: 5),
            phoneTextField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30),
            
            nextButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
        ])
    }
    
    @objc func nextButtonTapped(sender: UIButton) {
        if check(){
            let createAcc3VC = CreateAccountViewController3()
            createAcc3VC.modalPresentationStyle = .fullScreen
            self.present(createAcc3VC, animated: true)        }
    }
    
    func check() -> Bool {
        var flag = true
        //honeLabel.text = "Ingresa tu correo coppel"
        phoneLabel.textColor = .gray
        phoneTextField.layer.borderWidth = 0
        nameTextField.layer.borderWidth = 0
        lastNameTextField.layer.borderWidth = 0
        birthDateTextField.layer.borderWidth = 0

        
        
        
        guard let name = name, let lastName = lastName, let birthDate = birthDate, let phone = phone else {
            assertionFailure("No pueden ser nil")
            return false
        }
        if name.isEmpty {
            flag = false
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.borderColor = UIColor.red.cgColor
            
        }
        if lastName.isEmpty {
            flag = false
            lastNameTextField.layer.borderWidth = 1
            lastNameTextField.layer.borderColor = UIColor.red.cgColor

        }
        if birthDate.isEmpty {
            flag = false
            birthDateTextField.layer.borderWidth = 1
            birthDateTextField.layer.borderColor = UIColor.red.cgColor

        }
        if phone.isEmpty {
            flag = false
            phoneTextField.layer.borderWidth = 1
            phoneTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            if phone.count != 10 {
                flag = false
                phoneTextField.layer.borderWidth = 1
                phoneTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        
        return flag
    }
    
}

// MARK: CreateAccount2 TextField Delegate
extension CreateAccountViewController2: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = phoneTextField.text! as NSString
        
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func valueChanged(datePicker: UIDatePicker) {

        birthDateTextField.text = formatDate(date: birthDatePicker.date)
    }
    func formatDate(date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat.string(from: date)
    }
    
    @objc func cancelButtonTapped(){
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
}

