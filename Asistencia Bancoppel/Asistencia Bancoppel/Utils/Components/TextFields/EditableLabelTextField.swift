//
//  EditableLabelTextField.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 08/05/23.
//

import Foundation
import UIKit


@objc internal protocol EditableLabelTextFieldDelegate: AnyObject {
    func editableLabelTextFieldDidChange(identifier: String, text: String)
    @objc optional func editableLabelTextFieldDone(identifier: String)
}


internal class EditableLabelTextField: UIView {
    internal weak var delegate: EditableLabelTextFieldDelegate?
    internal var identifier: String = ""
    internal var inputValidation: TextFieldInputValidationEnum = .none
    internal var allowSpaces: Bool = true
    internal var maxLength: Int = 50
    internal var keyboardType: UIKeyboardType = .default {
        didSet {
            txtfContent.keyboardType = keyboardType
        }
    }
    private var titleFont: UIFont = .robotoBold(ofSize: 16) {
        didSet {
            lbTitle.font = titleFont
        }
    }
    internal var textFont: UIFont = .robotoRegular(ofSize: 16) {
        didSet {
            txtfContent.font = textFont
        }
    }
    internal var textAlignment: NSTextAlignment = .left {
        didSet {
            txtfContent.textAlignment = textAlignment
        }
    }
    internal var casing: TextFieldInputCasingEnum = .defaultCasing {
        didSet {
            textCasing()
        }
    }
    private var textfieldLeadingAnchor = NSLayoutConstraint()

    
    lazy var txtfContent: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = titleFont
        textfield.textColor = GlobalConstants.BancoppelColors.grayBex10
        textfield.leftView = UIView(frame: .init(x: 0, y: 0, width: Dimensions.margin10, height: 0))
        textfield.leftViewMode = .always
        textfield.rightView = UIView(frame: .init(x: 0, y: 0, width: Dimensions.margin10, height: 0))
        textfield.rightViewMode = .always
        textfield.layer.cornerRadius = 5
        textfield.backgroundColor = .clear
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textfield.returnKeyType = .done
        textfield.spellCheckingType = .no
        textfield.autocorrectionType = .no
        textfield.isUserInteractionEnabled = false
        textfield.adjustsFontSizeToFitWidth = true
        return textfield
    }()
    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = titleFont
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.setContentHuggingPriority(.init(999), for: .horizontal)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    internal init(title: String,
                  placeholder: String,
                  delegate: EditableLabelTextFieldDelegate?,
                  identifier: String = "",
                  maxLength: Int = 50,
                  keyboardType: UIKeyboardType = .default,
                  inputValidation: TextFieldInputValidationEnum = .none,
                  allowSpaces: Bool = true,
                  casing: TextFieldInputCasingEnum = .defaultCasing,
                  isSecure: Bool = false) {
        super.init(frame: .zero)
        
        lbTitle.text = title
        txtfContent.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: GlobalConstants.BancoppelColors.grayBex5,
                                                                            NSAttributedString.Key.font: UIFont.robotoItalic(ofSize: 16)])
        self.delegate = delegate
        self.identifier = identifier
        self.maxLength = maxLength
        self.keyboardType = keyboardType
        txtfContent.keyboardType = keyboardType
        self.inputValidation = inputValidation
        self.allowSpaces = allowSpaces
        self.casing = casing
        txtfContent.isSecureTextEntry = isSecure
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setComponents() {
        self.addSubview(txtfContent)
        self.addSubview(lbTitle)
    }
    
    private func setAutolayout() {
        textfieldLeadingAnchor = txtfContent.leadingAnchor.constraint(equalTo: lbTitle.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([
            txtfContent.topAnchor.constraint(equalTo: self.topAnchor),
            textfieldLeadingAnchor,
            txtfContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            txtfContent.heightAnchor.constraint(equalToConstant: 30),
            txtfContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            lbTitle.centerYAnchor.constraint(equalTo: txtfContent.centerYAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    
    internal func setText(text: String) {
        txtfContent.text = text
    }
    
    internal func getText() -> String {
        return txtfContent.text ?? ""
    }
    
    
    @objc func textFieldDidChange() {
        textCasing()
        delegate?.editableLabelTextFieldDidChange(identifier: identifier,
                                              text: txtfContent.text ?? "")
    }
    
    private func textCasing() {
        if self.casing == .uppercased {
            self.txtfContent.text = (self.txtfContent.text ?? "").uppercased()
        } else if self.casing == .lowercased {
            self.txtfContent.text = (self.txtfContent.text ?? "").lowercased()
        } else if self.casing == .capitalized {
            self.txtfContent.text = (self.txtfContent.text ?? "").capitalized
        }
    }

    internal func setSuccessStatus() {
        DispatchQueue.main.async {
            self.txtfContent.layer.borderWidth = 1
            self.txtfContent.layer.borderColor = GlobalConstants.BancoppelColors.greenBex5.cgColor
        }
        
    }
    
    internal func setDefaultStatus() {
        DispatchQueue.main.async {
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
    
    private func validateSpaces(_ replacementString: String, _ range: NSRange) -> Bool {
        if (((!allowSpaces) || (range.location == 0)) && (replacementString == " ")) {
            return false
        } else {
            return true
        }
    }
    
    private func validateLenght(_ replacementString: String, _ range: NSRange) -> Bool {
        let currentString = (txtfContent.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: replacementString)

        return newString.count <= maxLength
    }
    
    internal func setEditable(edit: Bool) {
        DispatchQueue.main.async {
            self.txtfContent.isUserInteractionEnabled = edit
            UIView.animate(withDuration: 0.3) {
                if edit {
                    self.txtfContent.font = self.textFont
                    self.txtfContent.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
                    self.textfieldLeadingAnchor.constant = 5
                } else {
                    self.txtfContent.font = self.titleFont
                    self.txtfContent.backgroundColor = .clear
                    self.textfieldLeadingAnchor.constant = 0
                }
                self.layoutIfNeeded()
            }
        }
    }
}


extension EditableLabelTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.editableLabelTextFieldDone?(identifier: identifier)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        
        guard validateLenght(string, range) else {
            return false
        }
        
        guard validateSpaces(string, range) else {
            return false
        }
        
        switch inputValidation {
        case .alphanumeric:
            return string.isAlphanumeric()
        case .spaAlphanumeric:
            return string.isSpaAlphanumeric()
        case .alphabetic:
            return string.isAlphabetic()
        case .spaAlphabetic:
            return string.isSpaAlphabetic()
        case .numeric:
            return string.isNumeric()
        case .email:
            guard string != "@" else {
                return true
            }
            return string.isEmailAllowedChar()
        case .none:
            return true
        }
    }
}
