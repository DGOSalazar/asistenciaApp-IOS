//
//  BottomTitleTextField.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 14/04/23.
//

import Foundation
import UIKit


@objc internal protocol BottomTitleTextFieldDelegate: AnyObject {
    func bottomTitleTextFieldDidChange(identifier: String, text: String)
    @objc optional func bottomTitleTextFieldDone(identifier: String)
}


internal class BottomTitleTextField: UIView {
    internal weak var delegate: BottomTitleTextFieldDelegate?
    internal var identifier: String = ""
    internal var inputValidation: TextFieldInputValidationEnum = .none
    internal var allowSpaces: Bool = true
    internal var maxLength: Int = 50
    internal var keyboardType: UIKeyboardType = .default {
        didSet {
            txtfContent.keyboardType = keyboardType
        }
    }
    
    
    
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
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textfield.returnKeyType = .done
        return textfield
    }()
    
    lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = Fonts.RobotoItalic.of(size: 12)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.setContentCompressionResistancePriority(.init(999), for: .vertical)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var lbError: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Fonts.RobotoItalic.of(size: 12)
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
                  delegate: BottomTitleTextFieldDelegate?,
                  identifier: String = "",
                  maxLength: Int = 50,
                  keyboardType: UIKeyboardType = .default,
                  inputValidation: TextFieldInputValidationEnum = .none,
                  allowSpaces: Bool = true,
                  isSecure: Bool = false) {
        super.init(frame: .zero)
        
        lbTitle.text = title
        txtfContent.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: GlobalConstants.BancoppelColors.grayBex5,
                                                                            NSAttributedString.Key.font: Fonts.RobotoItalic.of(size: 16)])
        self.delegate = delegate
        self.identifier = identifier
        self.maxLength = maxLength
        self.keyboardType = keyboardType
        txtfContent.keyboardType = keyboardType
        self.inputValidation = inputValidation
        self.allowSpaces = allowSpaces
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
        self.addSubview(lbError)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            txtfContent.topAnchor.constraint(equalTo: self.topAnchor),
            txtfContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            txtfContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            txtfContent.heightAnchor.constraint(equalToConstant: 30),
            
            lbTitle.topAnchor.constraint(equalTo: txtfContent.bottomAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: txtfContent.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: txtfContent.trailingAnchor),
            lbTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lbTitle.heightAnchor.constraint(equalToConstant: 16),
            
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
    
    
    @objc func textFieldDidChange() {
        delegate?.bottomTitleTextFieldDidChange(identifier: identifier, text: txtfContent.text ?? "")
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
}


extension BottomTitleTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.bottomTitleTextFieldDone?(identifier: identifier)
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
