//
//  DatePickerTextField.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 14/04/23.
//

import Foundation
import UIKit


@objc internal protocol DatePickerTextFieldDelegate: AnyObject {
    func datePickerTextFieldDidChange(identifier: String, text: String)
    @objc optional func datePickerTextFieldDone(identifier: String)
}


internal class DatePickerTextField: UIView {
    internal weak var delegate: DatePickerTextFieldDelegate?
    internal var identifier: String = ""
    private var dateFormat = ""
    internal var textFont: UIFont = .robotoMedium(ofSize: 16) {
        didSet {
            txtfContent.font = textFont
        }
    }
    internal var textAlignment: NSTextAlignment = .left {
        didSet {
            txtfContent.textAlignment = textAlignment
        }
    }
    
    
    lazy var txtfContent: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = .robotoMedium(ofSize: 16)
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
    
    lazy var dtpDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = .init(identifier: "es_MX")
        datePicker.addTarget(self, action: #selector(datePickerDidChange), for: .valueChanged)

        return datePicker
    }()
    

    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegular(ofSize: 16)
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
        label.font = .robotoItalic(ofSize: 12)
        label.textColor = GlobalConstants.BancoppelColors.redBex10
        label.isHidden = true
        label.setContentCompressionResistancePriority(.init(999), for: .vertical)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    internal init(title: String,
                  placeholder: String,
                  dateFormat: String = "dd/MM/yyyy",
                  delegate: DatePickerTextFieldDelegate?,
                  identifier: String = "",
                  minimumDate: Date? = nil,
                  maximumDate: Date? = Calendar.current.date(byAdding: .year, value: -18, to: Date())) {
        super.init(frame: .zero)
        
        self.identifier = identifier
        self.dateFormat = dateFormat
        self.dtpDatePicker.minimumDate = minimumDate
        self.dtpDatePicker.maximumDate = maximumDate
        lbTitle.text = title
        txtfContent.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: GlobalConstants.BancoppelColors.grayBex5,
                                                                            NSAttributedString.Key.font: UIFont.robotoItalic(ofSize: 16)])
        self.delegate = delegate
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setComponents() {
        self.addSubview(txtfContent)
        txtfContent.inputView = dtpDatePicker
        self.addSubview(lbTitle)
        self.addSubview(lbError)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            txtfContent.topAnchor.constraint(equalTo: self.topAnchor),
            txtfContent.leadingAnchor.constraint(equalTo: lbTitle.trailingAnchor, constant: ((lbTitle.text?.isEmpty ?? true) ? 0 : 5)),
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
    
    internal func getText() -> String {
        return txtfContent.text ?? ""
    }
    
    @objc func datePickerDidChange() {
        DispatchQueue.main.async {
            self.txtfContent.text = self.formatDate(date: self.dtpDatePicker.date)
            self.delegate?.datePickerTextFieldDidChange(identifier: self.identifier, text: self.txtfContent.text ?? "")
        }
    }
    
    @objc func doneButtonPressed() {
        DispatchQueue.main.async {
            self.datePickerDidChange()
            self.delegate?.datePickerTextFieldDone?(identifier: self.identifier)
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
        }
    }
    
    internal func setSuccessStatus() {
        DispatchQueue.main.async {
            self.lbError.text = ""
            self.lbError.isHidden = true
            self.txtfContent.layer.borderWidth = 1
            self.txtfContent.layer.borderColor = GlobalConstants.BancoppelColors.greenBex5.cgColor
        }
        
    }
    
    internal func setDefaultStatus() {
        DispatchQueue.main.async {
            self.lbError.text = ""
            self.lbError.isHidden = true
            self.txtfContent.layer.borderWidth = 0
            self.txtfContent.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return self.txtfContent.becomeFirstResponder()
    }
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return self.txtfContent.resignFirstResponder()
    }
}
