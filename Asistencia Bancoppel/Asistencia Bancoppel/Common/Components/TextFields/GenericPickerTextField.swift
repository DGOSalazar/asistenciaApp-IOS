//
//  GenericPickerTextField.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 14/04/23.
//

import Foundation
import UIKit


internal protocol GenericPickerTextFieldDelegate: AnyObject {
    func genericPickerTextFieldDidChange<T>(identifier: String, data: T?)
    func genericPickerTextFieldDone(identifier: String)
}


internal class GenericPickerTextField<T>: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    internal weak var delegate: GenericPickerTextFieldDelegate?
    internal var identifier: String = ""
    private var dateFormat = ""
    private var pickerData: [T] = []
    private var pickerDataTitles: [String] = []
    private var currentGeneric: T? = nil
    
    
    lazy var txtfContent: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = Fonts.RobotoRegular.of(size: 16)
        textfield.textColor = GlobalConstants.BancoppelColors.grayBex10
        textfield.leftView = UIView(frame: .init(x: 0, y: 0, width: 13, height: 0))
        textfield.leftViewMode = .always
        textfield.rightView = UIView(frame: .init(x: 0, y: 0, width: 13, height: 0))
        textfield.rightViewMode = .always
        textfield.layer.cornerRadius = 5
        textfield.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        textfield.returnKeyType = .done
        
        let inputAccesory = UIToolbar(frame: .init(x: 0, y: 0, width: 0, height: 30))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAccesory.setItems([spacer, doneButton], animated: true)
        textfield.inputAccessoryView = inputAccesory
        
        return textfield
    }()
    
    lazy var dtpPicker: UIPickerView = {
        let datePicker = UIPickerView()
        datePicker.backgroundColor = .systemBackground
        datePicker.delegate = self
        datePicker.dataSource = self

        return datePicker
    }()
    

    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.RobotoRegular.of(size: 16)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.setContentHuggingPriority(.init(999), for: .horizontal)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var lbError: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = Fonts.RobotoItalic.of(size: 12)
        label.textColor = GlobalConstants.BancoppelColors.redBex10
        label.isHidden = true
        label.setContentCompressionResistancePriority(.init(999), for: .vertical)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    internal init(title: String, placeholder: String, dataTitles: [String], genericData: [T], delegate: GenericPickerTextFieldDelegate?, identifier: String = "") {
        super.init(frame: .zero)
        
        self.identifier = identifier
        self.pickerDataTitles = dataTitles
        self.pickerData = genericData
        
        lbTitle.text = title
        txtfContent.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: GlobalConstants.BancoppelColors.grayBex4,
                                                                            NSAttributedString.Key.font: Fonts.RobotoItalic.of(size: 16)])
        self.delegate = delegate
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setComponents() {
        self.addSubview(txtfContent)
        txtfContent.inputView = dtpPicker
        self.addSubview(lbTitle)
        self.addSubview(lbError)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            txtfContent.topAnchor.constraint(equalTo: self.topAnchor),
            txtfContent.leadingAnchor.constraint(equalTo: lbTitle.trailingAnchor, constant: 5),
            txtfContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            txtfContent.heightAnchor.constraint(equalToConstant: 30),
            
            lbTitle.centerYAnchor.constraint(equalTo: txtfContent.centerYAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            lbError.topAnchor.constraint(equalTo: txtfContent.bottomAnchor),
            lbError.leadingAnchor.constraint(equalTo: txtfContent.leadingAnchor),
            lbError.trailingAnchor.constraint(equalTo: txtfContent.trailingAnchor),
            lbError.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lbError.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    

    
    @objc func doneButtonPressed() {
        DispatchQueue.main.async {
            self.delegate?.genericPickerTextFieldDone(identifier: self.identifier)
        }
    }
    

    func formatDate(date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = self.dateFormat
        return dateFormat.string(from: date)
    }
    
    internal func setFailureStatus(message: String) {
        DispatchQueue.main.async {
            self.txtfContent.layer.borderWidth = 1
            self.txtfContent.layer.borderColor = GlobalConstants.BancoppelColors.redBex10.cgColor
            self.lbError.text = message
            self.lbError.isHidden = false
            self.lbTitle.isHidden = true
        }
    }
    
    internal func setSuccessStatus() {
        DispatchQueue.main.async {
            self.lbError.text = ""
            self.lbError.isHidden = true
            self.lbTitle.isHidden = false
            self.txtfContent.layer.borderWidth = 1
            self.txtfContent.layer.borderColor = GlobalConstants.BancoppelColors.greenBex5.cgColor
        }
        
    }
    
    internal func setDefaultStatus() {
        DispatchQueue.main.async {
            self.lbError.text = ""
            self.lbError.isHidden = true
            self.lbTitle.isHidden = false
            self.txtfContent.layer.borderWidth = 0
            self.txtfContent.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerDataTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row <= (self.pickerData.count - 1) {
            self.currentGeneric = self.pickerData[row]
        } else {
            self.currentGeneric = nil
        }
        self.delegate?.genericPickerTextFieldDidChange(identifier: identifier, data: currentGeneric)
    }
}
