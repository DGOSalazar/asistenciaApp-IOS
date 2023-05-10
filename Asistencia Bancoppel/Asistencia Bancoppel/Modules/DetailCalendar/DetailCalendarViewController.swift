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
        
        return stack
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
        [labelQuestionName, labelQuestionDay].forEach{view.addSubview($0)}
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([ labelQuestionName.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                                      labelQuestionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                      labelQuestionDay.topAnchor.constraint(equalTo: labelQuestionName.bottomAnchor, constant: 2),
                                      labelQuestionDay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)])
       
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
