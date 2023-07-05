//
//  CalendarDay.swift
//  Asistencia Bancoppel
//
//  Created by Joel on 09/05/23.
//

import UIKit

class CalendarDay: UIView {
    
    var viewDayHeight: CGFloat  = Dimensions.margin80
    var viewDayWidth: CGFloat = Dimensions.margin80
    var viewHeaderHeight: CGFloat = Dimensions.margin20
    var viewHeaderWidth: CGFloat = Dimensions.margin80
    
    lazy var contentView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentGrayView: UIView = {
        let cortinaView = UIView()
        cortinaView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        cortinaView.translatesAutoresizingMaskIntoConstraints = false
        cortinaView.layer.cornerRadius = viewDayHeight / 4
        cortinaView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return cortinaView
    }()
    
     lazy var labelTitleDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 10)
        label.textColor = GlobalConstants.BancoppelColors.grayBex1
         label.textAlignment = .center
        
        return label
    }()
    
     lazy var labelNumberDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoBold(ofSize: 30)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var viewDay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.grayBex1
        view.layer.cornerRadius = viewDayHeight / 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.26
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return view
    }()
    
    private lazy var viewHeaderDay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        view.layer.cornerRadius = viewHeaderHeight / 2
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.26
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return view
    }()
    
    init(notCurrentDay: Bool = true) {
        super.init(frame: .zero)
        if notCurrentDay == true {
            labelNumberDay.textColor = GlobalConstants.BancoppelColors.grayBex5
            viewHeaderDay.backgroundColor = GlobalConstants.BancoppelColors.grayBex5
        }
        self.initComponents()
       // contentGrayView.isHidden = notCurrentDay
        self.autoLayout()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initComponents() {
        //viewDay.addSubview(contentGrayView)
        contentView.addSubview(viewDay)
        self.addSubview(contentView)
        viewHeaderDay.addSubview(labelTitleDay)
        [viewHeaderDay, labelNumberDay].forEach{viewDay.addSubview($0)}
    }
    
    
    private func autoLayout() {
        NSLayoutConstraint.activate([contentView.heightAnchor.constraint(equalToConstant: viewDayHeight),
                                     contentView.widthAnchor.constraint(equalToConstant: viewDayWidth),
            
                                     viewDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     viewDay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     viewDay.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     viewDay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     /*
                                     contentGrayView.leadingAnchor.constraint(equalTo: viewDay.leadingAnchor),
                                     contentGrayView.trailingAnchor.constraint(equalTo: viewDay.trailingAnchor),
                                     contentGrayView.topAnchor.constraint(equalTo: viewDay.topAnchor),
                                     contentGrayView.bottomAnchor.constraint(equalTo: viewDay.bottomAnchor),*/
                                    
                                     viewHeaderDay.heightAnchor.constraint(equalToConstant: viewHeaderHeight),
                                     viewHeaderDay.widthAnchor.constraint(equalToConstant: viewHeaderWidth),
                                   
                                     labelTitleDay.leadingAnchor.constraint(equalTo: viewHeaderDay.leadingAnchor, constant: 4),
                                     labelTitleDay.trailingAnchor.constraint(equalTo: viewHeaderDay.trailingAnchor, constant: -4),
                                     labelTitleDay.bottomAnchor.constraint(equalTo: viewHeaderDay.bottomAnchor, constant: -1),
                                     /*
                                     labelTitleDay.centerXAnchor.constraint(equalTo: viewHeaderDay.centerXAnchor),
                                     labelTitleDay.centerYAnchor.constraint(equalTo: viewHeaderDay.centerYAnchor),*/
                                     
                                     
                                     viewHeaderDay.topAnchor.constraint(equalTo: viewDay.topAnchor),
                                     viewHeaderDay.leadingAnchor.constraint(equalTo: viewDay.leadingAnchor),
                                     viewHeaderDay.trailingAnchor.constraint(equalTo: viewDay.trailingAnchor),
                                     
                                     labelNumberDay.topAnchor.constraint(equalTo: viewHeaderDay.bottomAnchor, constant: 4),
                                     labelNumberDay.leadingAnchor.constraint(equalTo: viewDay.leadingAnchor, constant: 11),
                                     labelNumberDay.trailingAnchor.constraint(equalTo: viewDay.trailingAnchor, constant: -11),
                                     labelNumberDay.bottomAnchor.constraint(equalTo: viewDay.bottomAnchor, constant: -4)
                                     
                                     
                                    ])
        
    }
}
