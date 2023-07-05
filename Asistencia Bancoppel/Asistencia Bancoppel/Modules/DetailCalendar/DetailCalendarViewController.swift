//
//  DetailCalendarViewController.swift
//  Asistencia Bancoppel
//
//  Created by Joel on 08/05/23.
//

import UIKit

class DetailCalendarViewController: UIViewController {
    
    var mockPeopleOne: UserAttendanceDataModel = UserAttendanceDataModel(name: "Rodrigo", fullname: "Rodrigo Joel Ramirez Hernandez", email: "joel.ramirez@coppel.com", position: UserPositionEnum.iosDev, profilePhotoURL: "", profilePhoto: UIImage(named: "profile"), employee: 1, team: "minuts")
    
    var mockPeopleTwo: UserAttendanceDataModel = UserAttendanceDataModel(name: "Joel", fullname: "Joel Hernandez", email: "joel.hernandez@coppel.com", position: UserPositionEnum.iosDev, profilePhotoURL: "", profilePhoto: UIImage(named: "profile"), employee: 1, team: "minuts")
    
    private var usersAttendingToday: [UserAttendanceDataModel] = []
    private var usersTableHeigthConstraint = NSLayoutConstraint()
    
    private lazy var navigationBarView: TopNavigationBarView = {
        let nav = TopNavigationBarView(title: "Calendario",
                                       style: .two,
                                       showBankIcon: false,
                                       showBackButton: true,
                                       showRightButton: true)
        nav.translatesAutoresizingMaskIntoConstraints = false
        return nav
    }()
    
    private let stackDays: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let dayOne: CalendarDay = {
        let day = CalendarDay()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "22"
        day.labelTitleDay.text = "Lunes"
        return day
    }()
    
    private let dayTwo: CalendarDay = {
        let day = CalendarDay(notCurrentDay: false)
        day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "23"
        day.labelTitleDay.text = "Martes"
        return day
    }()
    
    private let dayThree: CalendarDay = {
        let day = CalendarDay()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "24"
        day.labelTitleDay.text = "Miercoles"
        return day
    }()
    
    private let dayFour: CalendarDay = {
        let day = CalendarDay()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "25"
        day.labelTitleDay.text = "Jueves"
        return day
    }()
    
    private let dayFive: CalendarDay = {
        let day = CalendarDay()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "26"
        day.labelTitleDay.text = "Viernes"
        return day
    }()
    
    
    
    private let labelQuestionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegular(ofSize: 22)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.numberOfLines = 1
        label.text = "Joel ¿deseas asistir el"
        
        return label
    }()
    
    
    private let labelQuestionDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 22)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.numberOfLines = 1
        label.text = "Martes 23 de Mayo?"
        
        return label
    }()
    
    lazy var buttonRegisterAsistencia: MainButton = {
        let button = MainButton(title: "Registrar Asistencia", enable: true)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .robotoBold(ofSize: 18)
        button.addTarget(self, action: #selector(buttonAsistenciaPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.backgroundColor = .clear
        button.setImage(UIImage(named: GlobalConstants.Images.menuDetailCalendar), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let labelAsistentes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 24)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.numberOfLines = 1
        label.text = "7 Asistentes:"
        
        return label
    }()
    
    private lazy var tableViewPeople: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountCell.self, forCellReuseIdentifier: AccountCell.reuseID)
        tableView.rowHeight = AccountCell.rowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        
        tableView.layer.cornerRadius = 25
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.25
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.clipsToBounds = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        addComponents()
        autoLayout()
        usersAttendingToday.append(mockPeopleOne)
        usersAttendingToday.append(mockPeopleTwo)
        usersAttendingToday.append(mockPeopleOne)
        usersAttendingToday.append(mockPeopleTwo)
        usersAttendingToday.append(mockPeopleOne)
        usersAttendingToday.append(mockPeopleTwo)
        self.tableViewPeople.reloadData()
        self.updateTableHeight()
        
    }
    
    private func addComponents() {
        [navigationBarView ,labelQuestionName, labelQuestionDay, stackDays, buttonRegisterAsistencia, labelAsistentes, tableViewPeople].forEach{view.addSubview($0)}
        stackDays.addArrangedSubview(dayOne)
        stackDays.addArrangedSubview(dayTwo)
        stackDays.addArrangedSubview(dayThree)
        stackDays.addArrangedSubview(dayFour)
        stackDays.addArrangedSubview(dayFive)
        
    }
    
    private func autoLayout() {
        
        usersTableHeigthConstraint = tableViewPeople.heightAnchor.constraint(equalToConstant: CGFloat(Double(usersAttendingToday.count) * AccountCell.rowHeight))
        
        NSLayoutConstraint.activate([
            
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dayOne.heightAnchor.constraint(equalToConstant: dayOne.viewDayHeight),
            dayTwo.heightAnchor.constraint(equalToConstant: dayTwo.viewDayHeight),
            dayThree.heightAnchor.constraint(equalToConstant: dayThree.viewDayHeight),
            dayFive.heightAnchor.constraint(equalToConstant: dayFour.viewDayHeight),
            dayFour.heightAnchor.constraint(equalToConstant: dayFour.viewDayHeight),
            
            dayOne.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
            dayTwo.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
            dayThree.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
            dayFive.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
            dayFour.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
            
            
            
            labelQuestionName.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: Dimensions.margin30),
            labelQuestionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin15),
            labelQuestionDay.topAnchor.constraint(equalTo: labelQuestionName.bottomAnchor, constant: 2),
            labelQuestionDay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin20),
            
            /*
             stackDays.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin10),
             stackDays.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin10),*/
            stackDays.topAnchor.constraint(equalTo: labelQuestionDay.bottomAnchor, constant: Dimensions.margin30),
            stackDays.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonRegisterAsistencia.topAnchor.constraint(equalTo: stackDays.bottomAnchor, constant: Dimensions.margin30),
            buttonRegisterAsistencia.heightAnchor.constraint(equalToConstant: Dimensions.margin70),
            buttonRegisterAsistencia.widthAnchor.constraint(equalToConstant: 220),
            buttonRegisterAsistencia.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelAsistentes.topAnchor.constraint(equalTo: buttonRegisterAsistencia.bottomAnchor, constant: Dimensions.margin30),
            labelAsistentes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin30),
            
            tableViewPeople.topAnchor.constraint(equalTo: labelAsistentes.bottomAnchor, constant: Dimensions.margin20),
            tableViewPeople.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: Dimensions.margin30),
            tableViewPeople.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -Dimensions.margin30),
            usersTableHeigthConstraint
            
        ])
    }
    
    private func updateTableHeight() {
        DispatchQueue.main.async {
            self.usersTableHeigthConstraint.constant = CGFloat(Double(self.usersAttendingToday.count) * AccountCell.rowHeight)
        }
    }
    
    @objc private func buttonAsistenciaPressed(){
        print("Asistencia Registrada")
    }
    
}

extension DetailCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersAttendingToday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !usersAttendingToday.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.reuseID, for: indexPath) as? AccountCell
        
        guard let nonNilCell = cell else { return UITableViewCell() }
        
        nonNilCell.configure(with: usersAttendingToday[indexPath.row])
        
        return nonNilCell
    }
    
    
}
