//
//  ConfirmAsistenciaButton.swift
//  Asistencia Bancoppel
//
//  Created by usuario on 04/05/23.
//

import UIKit

class ConfirmAsistenciaButton: UIView {
    
    private let buttonSize: CGFloat = 30
    
    private lazy var buttonConfirmView: UIView = {
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .systemPink
        buttonView.layer.borderWidth = 5
        buttonView.clipsToBounds = false
        buttonView.layer.cornerRadius = (buttonSize / 2)
        
        return buttonView
    }()
    
    private lazy var imageIcon: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "cofirmIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setComponents()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setComponents(){
        self.addSubview(buttonConfirmView)
        buttonConfirmView.addSubview(imageIcon)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            buttonConfirmView.heightAnchor.constraint(equalToConstant: self.buttonSize),
            buttonConfirmView.widthAnchor.constraint(equalToConstant: self.buttonSize),
            imageIcon.centerYAnchor.constraint(equalTo: buttonConfirmView.centerYAnchor),
            imageIcon.centerXAnchor.constraint(equalTo: buttonConfirmView.centerXAnchor)
                                    ])
                                    
    }
    
    
}
