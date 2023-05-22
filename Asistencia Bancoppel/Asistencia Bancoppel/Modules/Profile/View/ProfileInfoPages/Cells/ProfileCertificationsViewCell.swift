//
//  ProfileCertificationsViewCell.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation
import UIKit




class ProfileCertificationsViewCell: UITableViewCell {
    static let identifier = "ProfileCertificationsViewCell"
    static let rowHeight: CGFloat = 110
    private var url: String?
    
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var certificateNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        return label
    }()
    
    lazy var certificateNumberLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        return label
    }()
    
    lazy var certificateEmissionDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        return label
    }()
    lazy var certificatePlatformLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        return label
    }()
    
    lazy var certificatePDFButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Descargar", for: .normal)
        button.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(openCertificate), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .robotoBold(ofSize: 14)
        return button
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setComponents()
        self.setAutolayout()
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        contentView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(certificateNameLabel)
        mainContainerView.addSubview(certificateNumberLabel)
        mainContainerView.addSubview(certificateEmissionDateLabel)
        mainContainerView.addSubview(certificatePlatformLabel)
        mainContainerView.addSubview(certificatePDFButton)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimensions.margin5),
            mainContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimensions.margin5),
            mainContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimensions.margin5),
            mainContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimensions.margin5),
            
            certificateNameLabel.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            certificateNameLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            certificateNameLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            certificateNumberLabel.topAnchor.constraint(equalTo: certificateNameLabel.bottomAnchor, constant: Dimensions.margin5),
            certificateNumberLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            certificateNumberLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            certificateEmissionDateLabel.topAnchor.constraint(equalTo: certificateNumberLabel.bottomAnchor, constant: Dimensions.margin5),
            certificateEmissionDateLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            certificateEmissionDateLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            certificatePlatformLabel.topAnchor.constraint(equalTo: certificateEmissionDateLabel.bottomAnchor, constant: Dimensions.margin5),
            certificatePlatformLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            certificatePlatformLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            certificatePDFButton.topAnchor.constraint(equalTo: certificatePlatformLabel.bottomAnchor, constant: Dimensions.margin5),
            certificatePDFButton.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            certificatePDFButton.trailingAnchor.constraint(lessThanOrEqualTo: mainContainerView.trailingAnchor),
            certificatePDFButton.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            certificatePDFButton.widthAnchor.constraint(equalToConstant: 100),
            certificatePDFButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    internal func setCell(data: ProfileCertificationsModel.Certification) {
        certificateNameLabel.text = "Nombre: \(data.certificateName ?? "")"
        certificateNumberLabel.text = "Número: \(data.certificateNum ?? "")"
        certificateEmissionDateLabel.text = "Emisión: \(data.emissionDate ?? "")"
        certificatePlatformLabel.text = "Emitido por: \(data.platformEmitted ?? "")"
        url = data.resourcePdf
    }
    
    @objc func openCertificate() {
        guard let nonNilStrURL = self.url, let nonNilURL = URL(string: nonNilStrURL) else {
            return
        }
        
        UIApplication.shared.open(nonNilURL)
    }
    
}
