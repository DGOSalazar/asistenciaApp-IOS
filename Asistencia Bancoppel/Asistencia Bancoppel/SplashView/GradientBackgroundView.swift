//
//  SplashView.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 13/02/23.
//

import UIKit


// MARK: GradientBackground ViewClass
class GradientBackgroundView: UIView {
    let topColor = UIColor(named: "splashGradientTop")
    let bottomColor = UIColor(named: "splashGradientBottom")
    
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.colors = [topColor?.cgColor ?? UIColor.blue.cgColor, bottomColor?.cgColor ?? UIColor.cyan.cgColor]
        layer.addSublayer(gradientLayer)
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.frame != bounds{
            gradientLayer.frame = bounds
        }
        
    }
}
