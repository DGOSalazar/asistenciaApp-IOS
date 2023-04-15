//
//  BottomTitleTextField.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 14/04/23.
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
        return label
    }()
    
    
    internal init(title: String, placeholder: String, delegate: BottomTitleTextFieldDelegate?, identifier: String = "", isSecure: Bool = false) {
        super.init(frame: .zero)
        
        self.identifier = identifier
        lbTitle.text = title
        txtfContent.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: GlobalConstants.BancoppelColors.grayBex4,
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
}


extension BottomTitleTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.bottomTitleTextFieldDone?(identifier: identifier)
        return true
    }
}
