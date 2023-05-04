//
//  MainButton.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import UIKit

class MainButton: UIButton {
    internal var style: MainButtonStyleEnum = .primary {
        didSet {
            self.setStatus(enable: self.isUserInteractionEnabled)
        }
    }
    
    internal init(title: String,
                  enable: Bool,
                  style: MainButtonStyleEnum = .primary) {
        super.init(frame: .zero)
   
        self.titleLabel?.numberOfLines = 1
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
        self.style = style
        self.updateTitle(title: title)
        self.setStatus(enable: enable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func updateTitle(title: String) {
        DispatchQueue.main.async {
            self.setTitle(title, for: .normal)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = (self.bounds.height/2.0)
    }
    
    internal func setStatus(enable: Bool) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = enable
            
            self.backgroundColor = enable ? self.style.getEnabledBackgroundColor() : self.style.getDisabledBackgroundColor()
            self.setTitleColor(enable ? self.style.getEnabledFontColor() : self.style.getDisabledFontColor(),
                               for: .normal)
            self.layer.borderWidth = self.style.getBorderSize()
            self.layer.borderColor = enable ? self.style.getEnabledBorderColor() : self.style.getDisabledBorderColor()
            self.titleLabel?.font = self.style.getFont()
        }
    }
}
