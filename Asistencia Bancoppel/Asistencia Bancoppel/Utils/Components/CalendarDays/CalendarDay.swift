//
//  CalendarDay.swift
//  Asistencia Bancoppel
//
//  Created by Joel on 09/05/23.
//

import UIKit

class CalendarDay: UIView {
    
    var viewDayHeight: CGFloat  = 77
    var viewDayWidth: CGFloat = 75.03
    var viewHeaderHeight: CGFloat = 22
    var viewHeaderWidth: CGFloat = 75
    
    
    
    private lazy var labelTitleDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex1
        
        return label
    }()
    
    private lazy var labelNumberDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 40)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        
        return label
    }()
    
    private lazy var viewDay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        
        return view
    }()
    
    private lazy var viewHeaderDay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initComponents() {
        self.addSubview(viewDay)
        viewHeaderDay.addSubview(labelTitleDay)
        [viewHeaderDay, labelNumberDay].forEach{viewDay.addSubview($0)}
    }
    
    /*
    init(isSelectedDay: Bool) {
         
    }*/
    
    private func autoLayout() {
        NSLayoutConstraint.activate([viewDay.heightAnchor.constraint(equalToConstant: viewDayHeight),
                                     viewDay.widthAnchor.constraint(equalToConstant: viewDayWidth),
                                    
                                     viewHeaderDay.heightAnchor.constraint(equalToConstant: viewHeaderHeight),
                                     viewHeaderDay.widthAnchor.constraint(equalToConstant: viewHeaderWidth),
                                     
                                     labelTitleDay.centerYAnchor.constraint(equalTo: viewHeaderDay.centerYAnchor),
                                     labelTitleDay.centerXAnchor.constraint(equalTo: viewHeaderDay.centerXAnchor),
                                     
                                     viewHeaderDay.topAnchor.constraint(equalTo: viewDay.topAnchor),
                                     viewHeaderDay.leadingAnchor.constraint(equalTo: viewDay.leadingAnchor),
                                     viewHeaderDay.trailingAnchor.constraint(equalTo: viewDay.trailingAnchor),
                                     
                                     labelNumberDay.topAnchor.constraint(equalTo: viewHeaderDay.bottomAnchor, constant: 4),
                                     labelNumberDay.leadingAnchor.constraint(equalTo: viewDay.leadingAnchor, constant: 11),
                                     labelNumberDay.trailingAnchor.constraint(equalTo: viewDay.trailingAnchor, constant: 11),
                                     labelNumberDay.bottomAnchor.constraint(equalTo: viewDay.bottomAnchor, constant: 4)
                                     
                                     
                                    ])
        
    }
}
