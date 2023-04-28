//
//  CalendarCellCollectionViewCell.swift
//  CalendarTwo
//
//  Created by Luis Díaz on 18/04/23.
//

import UIKit


internal protocol CustomCalendarViewCellDelegate: AnyObject {
    func notifyCalendarLuisViewCellTapped(dayData: CustomCalendarDayModel?)
}



class CustomCalendarViewCell: UICollectionViewCell {
    internal static let identifier = "CustomCalendarViewCell"
    private weak var delegate: CustomCalendarViewCellDelegate?
    private var dayData: CustomCalendarDayModel?
    
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    lazy var dateNumberLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .robotoRegular(ofSize: 12)
        return label
    }()
    
    lazy var availableSpotsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var availableSpotsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .robotoItalic(ofSize: 8)
        label.textColor = .white
        label.text = " "
        return label
    }()
    
    lazy var profilePhotoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.layer.borderWidth = 3
        view.layer.borderColor = GlobalConstants.BancoppelColors.yellowBex3.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var profilePhotoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.tintColor = .lightGray
        return view
    }()
    
    lazy var attendanceMarkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .topRight
        view.image = UIImage(named: "attendanceMark_icon")
        view.isHidden = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = false
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(dateNumberLabel)
        
        mainContainerView.addSubview(availableSpotsContainerView)
        availableSpotsContainerView.addSubview(availableSpotsLabel)
        
        mainContainerView.addSubview(profilePhotoContainerView)
        profilePhotoContainerView.addSubview(profilePhotoImageView)
        
        mainContainerView.addSubview(attendanceMarkImageView)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateNumberLabel.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 4),
            dateNumberLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 5),
            dateNumberLabel.widthAnchor.constraint(equalToConstant: 15),
            
            availableSpotsContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 3),
            availableSpotsContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -3),
            availableSpotsContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -4),
            
            availableSpotsLabel.topAnchor.constraint(equalTo: availableSpotsContainerView.topAnchor, constant: 2),
            availableSpotsLabel.leadingAnchor.constraint(equalTo: availableSpotsContainerView.leadingAnchor, constant: 5),
            availableSpotsLabel.trailingAnchor.constraint(equalTo: availableSpotsContainerView.trailingAnchor, constant: -5),
            availableSpotsLabel.bottomAnchor.constraint(equalTo: availableSpotsContainerView.bottomAnchor, constant: -2),
            
            
            
            profilePhotoContainerView.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            profilePhotoContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -6),
            profilePhotoContainerView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.6),
            profilePhotoContainerView.widthAnchor.constraint(equalTo: profilePhotoContainerView.heightAnchor),
            
            profilePhotoImageView.topAnchor.constraint(equalTo: profilePhotoContainerView.topAnchor),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: profilePhotoContainerView.leadingAnchor),
            profilePhotoImageView.trailingAnchor.constraint(equalTo: profilePhotoContainerView.trailingAnchor),
            profilePhotoImageView.bottomAnchor.constraint(equalTo: profilePhotoContainerView.bottomAnchor),
            
            
            attendanceMarkImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            attendanceMarkImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            attendanceMarkImageView.heightAnchor.constraint(equalTo: mainContainerView.heightAnchor, multiplier: 0.5),
            attendanceMarkImageView.widthAnchor.constraint(equalTo: profilePhotoContainerView.heightAnchor),
        ])
    }
    
    
    internal func setCell(dayData: CustomCalendarDayModel,
                          maxSpotsForDay: Int,
                          delegate: CustomCalendarViewCellDelegate?,
                          profilePhoto: UIImage) {
        DispatchQueue.main.async {
            self.clear()
            
            self.delegate = delegate
            self.dayData = dayData
            self.dateNumberLabel.textColor = dayData.style.getFontColor()
            self.dateNumberLabel.text = dayData.workDay.getDay()
            self.mainContainerView.backgroundColor = dayData.style.getBackgroundColor()
            
            if dayData.isAttendedDay {
                self.showAttendanceMark()
            } else if dayData.showProfilePhoto {
                self.showProfilePhoto(photo: profilePhoto)
            } else {
                self.showAvailableSpots(maxSpots: maxSpotsForDay)
            }
        }
    }
    
    private func showAttendanceMark() {
        self.attendanceMarkImageView.isHidden = false
    }
    
    private func showAvailableSpots(maxSpots: Int) {
        DispatchQueue.main.async {
            guard (self.dayData?.style == .enabled),
                    let attendanceData = self.dayData?.attendaceData else {
                return
            }
            
            let number = ((maxSpots - (attendanceData.email?.count ?? 0)))
            
            self.availableSpotsLabel.text = "\(number > 0 ? number : 0) Disponibles"
            self.availableSpotsContainerView.layer.cornerRadius = (self.availableSpotsContainerView.bounds.height / 2)
            let color = (number > 0 ? GlobalConstants.BancoppelColors.blueBex5 : GlobalConstants.BancoppelColors.grayBex7)
            self.availableSpotsContainerView.backgroundColor = color
            self.availableSpotsContainerView.isHidden = false
            self.isUserInteractionEnabled = number > 0
        }
    }
    
    private func showProfilePhoto(photo: UIImage) {
        DispatchQueue.main.async {
            guard (self.dayData?.style == .enabled || self.dayData?.style == .current) else {
                return
            }
            
            self.profilePhotoImageView.image = photo
            self.profilePhotoImageView.layer.cornerRadius = (self.profilePhotoImageView.bounds.height / 2)
            self.profilePhotoContainerView.layer.cornerRadius = (self.profilePhotoContainerView.bounds.height / 2)
            self.profilePhotoContainerView.isHidden = false
        }
    }
    
    private func clear() {
        self.attendanceMarkImageView.isHidden = true
        self.availableSpotsContainerView.isHidden = true
        self.isUserInteractionEnabled = false
        self.profilePhotoContainerView.isHidden = true
        self.profilePhotoImageView.image = nil
    }
    
    @objc private func cellTapped() {
        self.delegate?.notifyCalendarLuisViewCellTapped(dayData: self.dayData)
    }
}
