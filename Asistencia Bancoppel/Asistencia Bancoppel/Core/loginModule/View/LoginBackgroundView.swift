//
//  LoginBackgroundView.swift
//  Asistencia Bancoppel
//
//  Created by Joel Ramirez on 13/04/23.
//

import UIKit

class LoginBackgroundView: UIView {
    
    let bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginBG")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImage)
        //backgroundColor = UIColor(patternImage: bgImage.image!)
        NSLayoutConstraint.activate([
            bgImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
