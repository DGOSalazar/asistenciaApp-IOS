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
    
    private let stackDays: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let dayOne: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
       day.labelNumberDay.text = "15"
        day.labelTitleDay.text = "Lunes"
        return day
    }()
    
    private let dayTwo: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "16"
        day.labelTitleDay.text = "Martes"
        return day
    }()
    
    private let dayThree: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "17"
        day.labelTitleDay.text = "Miercoles"
        return day
    }()
    
    private let dayFour: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "18"
        day.labelTitleDay.text = "Jueves"
        return day
    }()
    
    private let dayFive: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "19"
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
        label.text = "Martes 9 de Mayo?"
        
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
    
    private lazy var contentViewTablePeople: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.26
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return view
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
        configHead()
        addComponents()
        autoLayout()
        usersAttendingToday.append(mockPeopleOne)
        usersAttendingToday.append(mockPeopleTwo)
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
        contentViewTablePeople.addSubview(tableViewPeople)
        [buttonMenu, labelQuestionName, labelQuestionDay, stackDays, buttonRegisterAsistencia, labelAsistentes, contentViewTablePeople].forEach{view.addSubview($0)}
        stackDays.addArrangedSubview(dayOne)
        stackDays.addArrangedSubview(dayTwo)
        stackDays.addArrangedSubview(dayThree)
        stackDays.addArrangedSubview(dayFour)
        stackDays.addArrangedSubview(dayFive)
       
    }
    
    private func autoLayout() {
        
        buttonMenu.heightAnchor.constraint(equalToConstant: 17).isActive = true
        buttonMenu.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        usersTableHeigthConstraint = tableViewPeople.heightAnchor.constraint(equalToConstant: CGFloat(Double(usersAttendingToday.count) * AccountCell.rowHeight))
        
        NSLayoutConstraint.activate([buttonMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     buttonMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            
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
                                     
                                     
            
                                     labelQuestionName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
                                      labelQuestionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                      labelQuestionDay.topAnchor.constraint(equalTo: labelQuestionName.bottomAnchor, constant: 2),
                                      labelQuestionDay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     
                                     stackDays.topAnchor.constraint(equalTo: labelQuestionDay.bottomAnchor, constant: 30),
                                     stackDays.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     stackDays.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     //stackDays.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                                     
                                     buttonRegisterAsistencia.topAnchor.constraint(equalTo: stackDays.bottomAnchor, constant: 30),
                                     buttonRegisterAsistencia.heightAnchor.constraint(equalToConstant: 59),
                                     buttonRegisterAsistencia.widthAnchor.constraint(equalToConstant: 220),
                                     buttonRegisterAsistencia.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     labelAsistentes.topAnchor.constraint(equalTo: buttonRegisterAsistencia.bottomAnchor, constant: 30),
                                     labelAsistentes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
                                     
                                     tableViewPeople.topAnchor.constraint(equalTo: contentViewTablePeople.topAnchor, constant: ),
                                     tableViewPeople.leadingAnchor.constraint(equalTo: contentViewTablePeople.leadingAnchor,constant: 28),
                                     tableViewPeople.trailingAnchor.constraint(equalTo: contentViewTablePeople.trailingAnchor,constant: -28),
                                     tableViewPeople.bottomAnchor.constraint(equalTo: contentViewTablePeople.bottomAnchor, constant: -10),
                                     
                                     contentViewTablePeople.topAnchor.constraint(equalTo: labelAsistentes.bottomAnchor, constant: 18),
                                     contentViewTablePeople.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     contentViewTablePeople.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     usersTableHeigthConstraint
                                      
                                      ])
    }
    
    private func updateTableHeight() {
        DispatchQueue.main.async {
                self.usersTableHeigthConstraint.constant = CGFloat(Double(self.usersAttendingToday.count) * AccountCell.rowHeight)
        }
    }
    
    private func configHead() {
        self.title = "Calendario"
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        let backButton = UIBarButtonItem()
        backButton.title = "Calendario"
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.isNavigationBarHidden = false
         
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
