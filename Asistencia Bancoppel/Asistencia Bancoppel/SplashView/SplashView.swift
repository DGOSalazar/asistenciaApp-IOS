//
//  SplashView.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 13/02/23.
//

import UIKit

// MARK: CenterLogoStackView
class AsistenciaLogoStackView: UIView {
    let centerLogoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let logoAsistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoAsistencia")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let colorbarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "colorbar")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let logoBancoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "logoBancoppel")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        autolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension AsistenciaLogoStackView {
    func autolayout() {
        
        centerLogoStackView.addArrangedSubview(logoAsistImageView)
        centerLogoStackView.addArrangedSubview(colorbarImageView)
        addSubview(centerLogoStackView)
        addSubview(logoBancoImageView)
        
        NSLayoutConstraint.activate([
            centerLogoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerLogoStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
        
            logoBancoImageView.topAnchor.constraint(equalTo: centerLogoStackView.bottomAnchor),
            //logoBancoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoBancoImageView.widthAnchor.constraint(equalToConstant: 82),
            logoBancoImageView.heightAnchor.constraint(equalToConstant: 15),

        ])
    }
    
}
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
