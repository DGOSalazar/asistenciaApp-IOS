//
//  CalendarLuis.swift
//  CalendarTwo
//
//  Created by Luis Díaz on 18/04/23.
//

import Foundation
import UIKit


internal protocol CustomCalendarViewDelegate: AnyObject {
    func notifySelectedDateChanged(_ selectedDate: Date)
    func notifyCellTapped(cellData: CustomCalendarDayModel?)
}


private enum CustomCalendarMonthModifier: Int {
    case previous = -1
    case current = 0
    case next = 1
}


internal class CustomCalendarView: UIView {
    internal weak var delegate: CustomCalendarViewDelegate?
    private var profilePhoto: UIImage = UIImage(named: "default_profile_fill_icon") ?? UIImage()
    private let numberOfCells: Int = 25
    private let todaysDate = Date().removeTimeData()
    
    
    var selectedDate: Date = Date() {
        didSet {
            dateTitleLabel.text = "\(selectedDate.getMonthName()) \(selectedDate.getYear())"
        }
    }
    
    var workDays: [CustomCalendarDayModel] = []
    var monthStartIndex = 0
    
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex5
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    lazy var topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var previousMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "left_arrow_icon"), for: .normal)
        button.tintColor = GlobalConstants.BancoppelColors.blueBex7
        button.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        return button
    }()
    
    lazy var dateTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GlobalConstants.BancoppelColors.blueBex7
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.text = "\(selectedDate.getMonthName()) \(selectedDate.getYear())"
        label.textAlignment = .center
        label.font = .robotoBold(ofSize: 12)
        return label
    }()
    
    lazy var nextMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "right_arrow_icon"), for: .normal)
        button.tintColor = GlobalConstants.BancoppelColors.blueBex7
        button.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        return button
    }()
    
    lazy var daysTitleContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        for day in Date().getWorkDaysNames() {
            let dayLabel = UILabel()
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            dayLabel.text = day
            dayLabel.textColor = .black
            dayLabel.adjustsFontSizeToFitWidth = true
            dayLabel.minimumScaleFactor = 0.5
            dayLabel.font = .robotoRegular(ofSize: 14)
            dayLabel.textAlignment = .center
            dayLabel.numberOfLines = 1
            dayLabel.backgroundColor = .white
            
            stack.addArrangedSubview(dayLabel)
        }
        
        return stack
    }()
    
    
    lazy var calendarCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCalendarViewCell.self, forCellWithReuseIdentifier: CustomCalendarViewCell.identifier)
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = GlobalConstants.BancoppelColors.grayBex5
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    internal init(profilePhoto: UIImage?, delegate: CustomCalendarViewDelegate?) {
        super.init(frame: .zero)
        
        self.profilePhoto = profilePhoto ?? self.profilePhoto
        self.delegate = delegate
        
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        
        self.setComponents()
        self.setAutolayout()
        
        setCalendarDays()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(mainContainerView)
        
        mainContainerView.addSubview(topContainerView)
        topContainerView.addSubview(previousMonthButton)
        topContainerView.addSubview(dateTitleLabel)
        topContainerView.addSubview(nextMonthButton)
        
        mainContainerView.addSubview(daysTitleContainerStack)
        mainContainerView.addSubview(calendarCollection)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            topContainerView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            topContainerView.heightAnchor.constraint(equalToConstant: 33),
            
            previousMonthButton.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            previousMonthButton.trailingAnchor.constraint(equalTo: dateTitleLabel.leadingAnchor, constant: -20),
            previousMonthButton.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            previousMonthButton.widthAnchor.constraint(equalToConstant: 30),
            
            dateTitleLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            dateTitleLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            dateTitleLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            dateTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            
            nextMonthButton.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            nextMonthButton.leadingAnchor.constraint(equalTo: dateTitleLabel.trailingAnchor, constant: 20),
            nextMonthButton.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            nextMonthButton.widthAnchor.constraint(equalToConstant: 30),
            
            
            daysTitleContainerStack.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 1),
            daysTitleContainerStack.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            daysTitleContainerStack.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            daysTitleContainerStack.heightAnchor.constraint(equalToConstant: 20),
            
            
            calendarCollection.topAnchor.constraint(equalTo: daysTitleContainerStack.bottomAnchor, constant: 1),
            calendarCollection.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            calendarCollection.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            calendarCollection.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            calendarCollection.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    @objc func nextMonth() {
        setCalendarDays(modifier: .next)
    }
    
    @objc func previousMonth() {
        setCalendarDays(modifier: .previous)
    }
    
    
    
    private func setCalendarDays(modifier: CustomCalendarMonthModifier = .current) {
        DispatchQueue.main.async { [self] in
            self.workDays = []
            self.selectedDate = self.getMonth(modifier: modifier)
            self.monthStartIndex = self.selectedDate.getFirstDayOfMonth().getWorkDayIndex()
            
            // Previous
            
            let previousMonthDate = self.getMonth(modifier: .previous)
            let previousMonthWorkDays = previousMonthDate.getWorkDaysOfMonth().map {
                CustomCalendarDayModel(workDay: $0,
                                style: self.getCellStyle(date: $0, differentMonth: true))
            }
            
            let previousDaysStartIndex = ((previousMonthWorkDays.count) - self.monthStartIndex)
            for previousDaysIndex in previousDaysStartIndex ..< previousMonthWorkDays.count {
                self.workDays.append(previousMonthWorkDays[previousDaysIndex])
            }
            
            
            // Current
            let currentMonthWorkDays = self.selectedDate.getWorkDaysOfMonth().map {
                CustomCalendarDayModel(workDay: $0,
                                style: self.getCellStyle(date: $0))
            }
            self.workDays.append(contentsOf: currentMonthWorkDays)
     
            
            // next
            let nextMonthDate = self.getMonth(modifier: .next)
            let nextMonthWorkDays = nextMonthDate.getWorkDaysOfMonth().map {
                CustomCalendarDayModel(workDay: $0,
                                style: self.getCellStyle(date: $0, differentMonth: true))
            }
            
            let nextDaysEndIndex = (self.numberOfCells - (self.monthStartIndex + (currentMonthWorkDays.count - 1)))
            for nextDaysIndex in 0 ..< nextDaysEndIndex {
                self.workDays.append(nextMonthWorkDays[nextDaysIndex])
            }
            
            
            self.calendarCollection.reloadData()
        }
    }
    
    private func getMonth(modifier: CustomCalendarMonthModifier = .current) -> Date {
        guard let date = self.selectedDate.calendar.date(byAdding: Calendar.Component.month, value: modifier.rawValue, to: self.selectedDate) else {
            return Date()
        }

        return date
    }
    
    func getCellStyle(date: Date, differentMonth: Bool = false) -> CustomCalendarCellStyleEnum {
        if date < todaysDate {
            return CustomCalendarCellStyleEnum.disabled
        } else if date == todaysDate {
            return CustomCalendarCellStyleEnum.current
        } else if (date > todaysDate && (!differentMonth)) {
            return CustomCalendarCellStyleEnum.enabled
        } else {
            return CustomCalendarCellStyleEnum.unavailable
        }
    }
}


extension CustomCalendarView: UICollectionViewDelegate {
    
}

extension CustomCalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCalendarViewCell.identifier, for: indexPath) as? CustomCalendarViewCell
        if (indexPath.row < workDays.count) {
            let workDayData = workDays[(indexPath.row)]
            cell?.setCell(dayData: workDayData, delegate: self)
            cell?.showAvailableSpots(number: -1)
            cell?.showProfilePhoto(photo: self.profilePhoto)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = ((collectionView.bounds.width/5.0) - 1)
        let cellHeight = ((collectionView.bounds.height/5.0))
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension CustomCalendarView: CustomCalendarViewCellDelegate {
    func notifyCalendarLuisViewCellTapped(dayData: CustomCalendarDayModel?) {
        self.delegate?.notifyCellTapped(cellData: dayData)
    }
}
