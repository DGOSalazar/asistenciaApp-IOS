//
//  LeftTitleTextField.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 14/04/23.
//

import Foundation
import UIKit


@objc internal protocol LeftTitleTextFieldDelegate: AnyObject {
    func leftTitleTextFieldDidChange(identifier: String, text: String)
    @objc optional func leftTitleTextFieldDone(identifier: String)
}


internal class LeftTitleTextField: UIView {
    internal weak var delegate: LeftTitleTextFieldDelegate?
    internal var identifier: String = ""
    
    
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
    
    
    internal init(title: String, placeholder: String, delegate: LeftTitleTextFieldDelegate?, identifier: String = "", isSecure: Bool = false) {
        super.init(frame: .zero)
        
        self.identifier = identifier
        lbTitle.text = title
        txtfContent.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: GlobalConstants.BancoppelColors.grayBex5,
                                                                            NSAttributedString.Key.font: Fonts.RobotoItalic.of(size: 16)])
        txtfContent.isSecureTextEntry = isSecure
        self.delegate = delegate
        
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
    
    internal func getText() -> String {
        return txtfContent.text ?? ""
    }
    
    
    @objc func textFieldDidChange() {
        delegate?.leftTitleTextFieldDidChange(identifier: identifier, text: txtfContent.text ?? "")
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


extension LeftTitleTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.leftTitleTextFieldDone?(identifier: identifier)
        return true
    }
}
