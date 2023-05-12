//
//  ProfileInitiativesViewCell.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 09/05/23.
//

import Foundation
import UIKit


class ProfileInitiativesViewCell: UITableViewCell {
    static let identifier = "ProfileInitiativesViewCell"
    static let rowHeight: CGFloat = 60
    
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        return label
    }()
    
    lazy var releasedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoItalic(ofSize: 12)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        return label
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setComponents()
        self.setAutolayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        contentView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(titleLabel)
        mainContainerView.addSubview(releasedLabel)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: Dimensions.margin5),
            titleLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin5),
            titleLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin5),
            
            releasedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimensions.margin5),
            releasedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releasedLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            releasedLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -Dimensions.margin5),
        ])
    }
    
    
    internal func setCell(data: ProfileProjectsModel.Project) {
        titleLabel.text = "Iniciativa liberada: \(data.projectName ?? "")"
        releasedLabel.text = "Liberada en el Q: \(data.releaseDate ?? "")"
    }
    
}
