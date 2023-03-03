//
//  CreateAccountViewController3.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 21/02/23.
//


import UIKit

class CreateAccountViewController3: UIViewController {
    
    let inicOptions = ["Saldo Ya", "Creditos", "Abonos Coppel", "Pagare"]
    let jobOptions = ["Tester/QA", "FrontEnd", "BackEnd", "Analista", "Scrum Master"]
    
    var job: String? {
        return jobTextField.text
    }
    var inic: String? {
        return inicTextField.text
    }
    var colab: String? {
        return colabTextField.text
    }
    
    let logoAsistView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lastStepLabel: UILabel = {
        let label = UILabel()
        label.text = "¡Ultimo Paso!"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Juan Ramon Rodriguez Gomez"
        label.textColor = UIColor(named: "splashGradientBottom")
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let uploadImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.text = "Puesto: "
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    lazy var jobTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "Roboto-Regular", size: 16)
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.cornerRadius = 5
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.tag = 1
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        textfield.inputView = pickerView
        pickerView.backgroundColor = .secondarySystemBackground
        return textfield
    }()
    
    let inicLabel: UILabel = {
        let label = UILabel()
        label.text = "Iniciativa: "
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var inicTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "Roboto-Regular", size: 16)
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.cornerRadius = 5
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.tag = 2
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        textfield.inputView = pickerView
        pickerView.backgroundColor = .secondarySystemBackground
        return textfield
    }()
    // falta su uipicker

    let colabLabel: UILabel = {
        let label = UILabel()
        label.text = "No de Colaborador: "
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let colabTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont(name: "Roboto-Regular", size: 16)
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.cornerRadius = 5
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finalizar", for: [])
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "splashGradientBottom")
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 22)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("Cancelar", for: [])
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(jobTextField.tag)
        print(inicTextField.tag)
        autolayout()
    }
    
    @objc func nextButtonTapped(sender: UIButton) {
        if check(){
            self.view.window?.rootViewController?.dismiss(animated: true)
        }
    }
    
    @objc func cancelButtonTapped(){
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    func check() -> Bool {
        var flag = true
        //honeLabel.text = "Ingresa tu correo coppel"
        jobTextField.layer.borderWidth = 0
        inicTextField.layer.borderWidth = 0
        colabTextField.layer.borderWidth = 0

        guard let job = job, let colab = colab, let inic = inic
        else {
            assertionFailure("No pueden ser nil")
            return false
        }
        if job.isEmpty {
            flag = false
            jobTextField.layer.borderWidth = 1
            jobTextField.layer.borderColor = UIColor.red.cgColor
            
        }
        if colab.isEmpty {
            flag = false
            colabTextField.layer.borderWidth = 1
            colabTextField.layer.borderColor = UIColor.red.cgColor

        }
        if inic.isEmpty {
            flag = false
            inicTextField.layer.borderWidth = 1
            inicTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        return flag
    }
    
    
    func autolayout(){
        view.addSubview(logoAsistView)
        view.addSubview(lastStepLabel)
        view.addSubview(uploadImageView)
        view.addSubview(nameLabel)
        view.addSubview(jobLabel)
        view.addSubview(jobTextField)
        view.addSubview(inicLabel)
        view.addSubview(inicTextField)
        view.addSubview(colabLabel)
        view.addSubview(colabTextField)
        view.addSubview(finishButton)
        view.addSubview(cancelButton)
        
        
        NSLayoutConstraint.activate([
            
            logoAsistView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoAsistView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoAsistView.heightAnchor.constraint(equalToConstant: 60),
            logoAsistView.widthAnchor.constraint(equalToConstant: 250),
            
            lastStepLabel.topAnchor.constraint(equalTo: logoAsistView.bottomAnchor, constant: 30),
            lastStepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            uploadImageView.heightAnchor.constraint(equalToConstant: 100),
            uploadImageView.widthAnchor.constraint(equalToConstant: 100),
            uploadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadImageView.topAnchor.constraint(equalTo: lastStepLabel.bottomAnchor, constant: 30),

            nameLabel.topAnchor.constraint(equalTo: uploadImageView.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            jobLabel.centerYAnchor.constraint(equalTo: jobTextField.centerYAnchor),
            jobLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            jobLabel.widthAnchor.constraint(equalToConstant: 60),
            
            jobTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: jobTextField.trailingAnchor, multiplier: 5),
            jobTextField.leadingAnchor.constraint(equalTo: jobLabel.trailingAnchor),
            jobTextField.heightAnchor.constraint(equalToConstant: 30),
            
            inicLabel.centerYAnchor.constraint(equalTo: inicTextField.centerYAnchor),
            inicLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            inicLabel.widthAnchor.constraint(equalToConstant: 80),
            
            inicTextField.topAnchor.constraint(equalTo: jobTextField.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: inicTextField.trailingAnchor, multiplier: 5),
            inicTextField.leadingAnchor.constraint(equalTo: inicLabel.trailingAnchor),
            inicTextField.heightAnchor.constraint(equalToConstant: 30),
            
            colabLabel.centerYAnchor.constraint(equalTo: colabTextField.centerYAnchor),
            colabLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            colabLabel.widthAnchor.constraint(equalToConstant: 150),
            
            colabTextField.topAnchor.constraint(equalTo: inicTextField.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: colabTextField.trailingAnchor, multiplier: 5),
            colabTextField.leadingAnchor.constraint(equalTo: colabLabel.trailingAnchor),
            colabTextField.heightAnchor.constraint(equalToConstant: 30),
            
            finishButton.heightAnchor.constraint(equalToConstant: 60),
            finishButton.widthAnchor.constraint(equalToConstant: 200),
            finishButton.topAnchor.constraint(equalTo: colabTextField.bottomAnchor, constant: 45),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
}
extension CreateAccountViewController3: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == jobTextField.inputView {
            return jobOptions.count
        }
        if pickerView == inicTextField.inputView {
            return inicOptions.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == jobTextField.inputView {
            return jobOptions[row]
        }
        if pickerView == inicTextField.inputView {
            return inicOptions[row]
        }
        
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == inicTextField.inputView {
            return inicTextField.text = inicOptions[row]
        }
        if pickerView == jobTextField.inputView {
            return jobTextField.text = jobOptions[row]
        }
        
    }
}

