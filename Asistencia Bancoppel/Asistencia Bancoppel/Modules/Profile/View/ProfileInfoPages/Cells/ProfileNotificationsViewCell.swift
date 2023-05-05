//
//  ProfileNotificationsViewCell.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 04/05/23.
//

import Foundation
import UIKit


internal protocol ProfileNotificationsViewCellDelegate: AnyObject {
    func notifyProfileNotificationsViewCellTapped(data: ProfileNotificationModel?)
}



class ProfileNotificationsViewCell: UITableViewCell {
    static let identifier = "ProfileNotificationsViewCell"
    static let rowHeight: CGFloat = 80
    private var cellData: ProfileNotificationModel?
    private weak var delegate: ProfileNotificationsViewCellDelegate?
    
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    lazy var profilePhotoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemBlue
        view.tintColor = .lightGray
        return view
    }()

    
    lazy var contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.font = .robotoRegular(ofSize: 14)
        return label
    }()
    
    lazy var timePassedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.font = .robotoItalic(ofSize: 10)
        return label
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        self.contentView.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        
        self.setComponents()
        self.setAutolayout()
        
        profilePhotoImageView.layer.cornerRadius = ((ProfileNotificationsViewCell.rowHeight*0.5)/2.0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        contentView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(contentContainer)
        
        contentContainer.addSubview(profilePhotoImageView)
        contentContainer.addSubview(titleLabel)
        contentContainer.addSubview(timePassedLabel)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            
            contentContainer.topAnchor.constraint(greaterThanOrEqualTo: mainContainerView.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: Dimensions.margin20),
            contentContainer.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -Dimensions.margin20),
            contentContainer.bottomAnchor.constraint(lessThanOrEqualTo: mainContainerView.bottomAnchor),
            contentContainer.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
            
            profilePhotoImageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            profilePhotoImageView.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            profilePhotoImageView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.5),
            profilePhotoImageView.widthAnchor.constraint(equalTo: profilePhotoImageView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: Dimensions.margin10),
            titleLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: Dimensions.margin10),
            titleLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            
            timePassedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimensions.margin5),
            timePassedLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: Dimensions.margin10),
            timePassedLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            timePassedLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -Dimensions.margin10),
        ])
    }
    
    
    internal func setCell(data: ProfileNotificationModel,
                          delegate: ProfileNotificationsViewCellDelegate?) {
        self.delegate = delegate
        profilePhotoImageView.image = data.type.getIcon()
        titleLabel.text = data.title
        cellData = data
        timePassedLabel.text = data.date.getFormattedDate()
    }
    

    @objc private func cellTapped() {
        self.delegate?.notifyProfileNotificationsViewCellTapped(data: cellData)
    }
}
