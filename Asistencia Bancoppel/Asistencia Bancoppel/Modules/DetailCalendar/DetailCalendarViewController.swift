//
//  DetailCalendarViewController.swift
//  Asistencia Bancoppel
//
//  Created by Joel on 08/05/23.
//

import UIKit

class DetailCalendarViewController: UIViewController {
    
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
       day.labelNumberDay.text = "8"
        day.labelTitleDay.text = "Lunes"
        return day
    }()
    
    private let dayTwo: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "9"
        day.labelTitleDay.text = "Martes"
        return day
    }()
    
    private let dayThree: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "10"
        day.labelTitleDay.text = "Miercoles"
        return day
    }()
    
    private let dayFour: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "11"
        day.labelTitleDay.text = "Jueves"
        return day
    }()
    
    private let dayFive: CalendarDay = {
       let day = CalendarDay()
       day.translatesAutoresizingMaskIntoConstraints = false
        day.labelNumberDay.text = "12"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHead()
        addComponents()
        autoLayout()
    }
    
    private func addComponents() {
        [buttonMenu, labelQuestionName, labelQuestionDay, stackDays, buttonRegisterAsistencia, labelAsistentes].forEach{view.addSubview($0)}
        stackDays.addArrangedSubview(dayOne)
        stackDays.addArrangedSubview(dayTwo)
        stackDays.addArrangedSubview(dayThree)
        stackDays.addArrangedSubview(dayFour)
        stackDays.addArrangedSubview(dayFive)
       
    }
    
    private func autoLayout() {
        
        buttonMenu.heightAnchor.constraint(equalToConstant: 17).isActive = true
        buttonMenu.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
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
                                     buttonRegisterAsistencia.widthAnchor.constraint(equalToConstant: 200),
                                     buttonRegisterAsistencia.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     labelAsistentes.topAnchor.constraint(equalTo: buttonRegisterAsistencia.bottomAnchor, constant: 30),
                                     labelAsistentes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33)
                                      
                                      ])
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
