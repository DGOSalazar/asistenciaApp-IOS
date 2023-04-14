//
//  MainButton.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import UIKit

class MainButton: UIButton {
    internal init(title: String, enable: Bool) {
        super.init(frame: .zero)
        
        self.titleLabel?.font = Fonts.RobotoBold.of(size: 22)
        self.layer.cornerRadius = 29.5
        self.updateTitle(title: title, enable: enable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func updateTitle(title: String, enable: Bool) {
        DispatchQueue.main.async {
            self.setTitle(title, for: .normal)
            self.setStatus(enable: enable)
        }
    }
    
    internal func setStatus(enable: Bool) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = enable
            if enable {
                self.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
                self.setTitleColor(.white, for: .normal)
            } else {
                self.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
                self.setTitleColor(GlobalConstants.BancoppelColors.grayBex10, for: .normal)
            }
        }
    }
}
