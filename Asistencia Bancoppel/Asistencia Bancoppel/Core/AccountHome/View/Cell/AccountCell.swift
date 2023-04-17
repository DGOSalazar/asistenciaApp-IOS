//
//  AccountCell.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit

class AccountCell: UITableViewCell {
        
    static let reuseID = "AccountCellId"
    static let rowHeight: CGFloat = 55
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imgPhoto: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 18
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        image.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            let containerImage = UIImage(systemName: "person.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
            image.image = containerImage
        }
        
        return image
    }()
    
    private let lbName: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nombre"
        label.font = Fonts.Roboto.of(size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let lbRol : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = Fonts.Roboto.of(size: 10)
        label.text = "Rol"
        return label
    }()
    
    private let vwUnderline : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor =  GlobalConstants.BancoppelColors.blueBex7
        return view
    }()
    
   
    
    func initComponents(){
        addComponents()
        setAutoLayout()
    }
    
    func addComponents(){
        contentView.addSubview(vwUnderline)
        vwUnderline.addSubview(imgPhoto)
        vwUnderline.addSubview(lbRol)
        vwUnderline.addSubview(lbName)
    }
    
    func setAutoLayout(){
        NSLayoutConstraint.activate([
            //vwUnderline.heightAnchor.constraint(equalToConstant: 30),
            
            imgPhoto.bottomAnchor.constraint(equalTo: vwUnderline.bottomAnchor, constant: 1),
            imgPhoto.trailingAnchor.constraint(equalTo: lbRol.leadingAnchor, constant: -20),
            imgPhoto.heightAnchor.constraint(equalToConstant: 40),
            imgPhoto.widthAnchor.constraint(equalToConstant: 40),
            
            lbRol.leadingAnchor.constraint(equalTo: vwUnderline.leadingAnchor, constant: 50),
            lbRol.topAnchor.constraint(equalTo: vwUnderline.topAnchor, constant: 4),
            
            lbName.leadingAnchor.constraint(equalTo: vwUnderline.leadingAnchor, constant: 50),
            lbName.bottomAnchor.constraint(equalTo: vwUnderline.topAnchor, constant: -0),
            
            vwUnderline.heightAnchor.constraint(equalToConstant: 19),
            vwUnderline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            vwUnderline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            vwUnderline.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}



extension AccountCell {
    func configure(with account: Account) {

        lbName.text = account.accountName
        lbRol.text = account.rolType.rawValue

        switch account.rolType {
       
        case .TesterQA:
            vwUnderline.backgroundColor = GlobalConstants.BancoppelColors.yellowBex3
            
        case .DevelomentAndroid:
            vwUnderline.backgroundColor = GlobalConstants.BancoppelColors.greenBex3
            
        case .BussinessAnalyst:
            vwUnderline.backgroundColor = GlobalConstants.BancoppelColors.pinkBex4
            
        case .DevelomentBackend:
            vwUnderline.backgroundColor = GlobalConstants.BancoppelColors.blueBex3

        case .ScrumMaster:
            vwUnderline.backgroundColor = GlobalConstants.BancoppelColors.orangeBex3
            
        case .DevelomentiOS:
            vwUnderline.backgroundColor = GlobalConstants.BancoppelColors.purpleBex5
        }
    }
}
