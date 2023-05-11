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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHead()
        addComponents()
        autoLayout()
    }
    
    private func addComponents() {
        view?.addSubview(stackDays)
        [labelQuestionName, labelQuestionDay].forEach{view.addSubview($0)}
        stackDays.addArrangedSubview(dayOne)
        stackDays.addArrangedSubview(dayTwo)
        stackDays.addArrangedSubview(dayThree)
        stackDays.addArrangedSubview(dayFour)
        stackDays.addArrangedSubview(dayFive)
       
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([dayOne.heightAnchor.constraint(equalToConstant: dayOne.viewDayHeight),
                                     dayTwo.heightAnchor.constraint(equalToConstant: dayTwo.viewDayHeight),
                                     dayThree.heightAnchor.constraint(equalToConstant: dayThree.viewDayHeight),
                                     dayFive.heightAnchor.constraint(equalToConstant: dayFour.viewDayHeight),
                                     dayFour.heightAnchor.constraint(equalToConstant: dayFour.viewDayHeight),
                                     
                                     dayOne.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
                                     dayTwo.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
                                     dayThree.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
                                     dayFive.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
                                     dayFour.widthAnchor.constraint(equalToConstant: dayOne.viewDayWidth),
                                     
                                     
            
                                     labelQuestionName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                                      labelQuestionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                      labelQuestionDay.topAnchor.constraint(equalTo: labelQuestionName.bottomAnchor, constant: 2),
                                      labelQuestionDay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     
                                     stackDays.topAnchor.constraint(equalTo: labelQuestionDay.bottomAnchor, constant: 20),
                                     stackDays.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     stackDays.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     //stackDays.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                                      
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
    
}
