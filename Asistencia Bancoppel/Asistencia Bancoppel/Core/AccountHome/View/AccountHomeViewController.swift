//
//  AccountHomeViewController.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit

class AccountHomeViewController: UIViewController {
    
    var accounts : [Account] = []
    
    override func viewDidLoad() {
        initComponents()
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
    }
 
    
    private let vwHeader : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        return view
    }()
    
    private let imgLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: GlobalConstants.Images.bancoppelWhite)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let stvContainer : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let lbGreetings: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¡Hola, Hector!"
        label.font = Fonts.Roboto.of(size: 28)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let lbDate: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hoy es Viernes 06 de Enero de 2023."
        label.font = Fonts.Roboto.of(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let lbReminder: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recuerda registrarte para la próxima semana."
        label.font = Fonts.Roboto.of(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var btnMenu: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.backgroundColor = .clear
        button.setImage(UIImage(named: GlobalConstants.Images.menuLoginWhite), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scvContainer: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return scrollView
    }()
    
    private let vwContainer : UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = GlobalConstants.BancoppelColors.grayBex2
        return headerView
    }()
    
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.datePickerMode = .date
        datePicker.layer.masksToBounds = false;
        datePicker.layer.shadowOffset = CGSize(width: .zero, height: 8.0)
        datePicker.layer.shadowRadius = 10.0
        datePicker.layer.shadowColor = UIColor.black.cgColor
        datePicker.layer.shadowOpacity = 0.5
        datePicker.backgroundColor = .white
        return datePicker
    }()
    
    
    private let stvDataOfTheDay : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let lbPersonsInTheOffice: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hoy están en oficina:"
        label.font = Fonts.Roboto.of(size: 28)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let lbNumberOfPeople: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 Asistentes."
        label.font = Fonts.Roboto.of(size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var tbvPeople: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountCell.self, forCellReuseIdentifier: AccountCell.reuseID)
        tableView.rowHeight = AccountCell.rowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 25
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.layer.shadowOffset = CGSize(width: .zero, height: 8.0)
        tableView.layer.shadowRadius = 100.0
        tableView.layer.shadowColor = UIColor.blue.cgColor
        tableView.layer.shadowOpacity = 0.5
        tableView.clipsToBounds = true
        return tableView
    }()

    
    func initComponents(){
        fetchData()
        addComponents()
        setAutoLayout()
        
    }
    
    func addComponents(){
        view.addSubview(vwHeader)
        vwHeader.addSubview(imgLogo)
        vwHeader.addSubview(stvContainer)
        stvContainer.addArrangedSubview(lbGreetings)
        stvContainer.addArrangedSubview(lbDate)
        vwHeader.addSubview(lbReminder)
        vwHeader.addSubview(btnMenu)
        view.addSubview(scvContainer)
        scvContainer.addSubview(vwContainer)
        vwContainer.addSubview(datePicker)
        vwContainer.addSubview(stvDataOfTheDay)
        stvDataOfTheDay.addArrangedSubview(lbPersonsInTheOffice)
        stvDataOfTheDay.addArrangedSubview(lbNumberOfPeople)
        vwContainer.addSubview(tbvPeople)
    }
    
    func setAutoLayout(){
        
        imgLogo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imgLogo.widthAnchor.constraint(equalToConstant: 82).isActive = true
        
        btnMenu.heightAnchor.constraint(equalToConstant: 17).isActive = true
        btnMenu.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        vwContainer.widthAnchor.constraint(equalTo: scvContainer.widthAnchor).isActive = true

        NSLayoutConstraint.activate([
            //MARK: Header with your data
            vwHeader.heightAnchor.constraint(equalToConstant: 210),
            vwHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vwHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vwHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imgLogo.topAnchor.constraint(equalTo: vwHeader.topAnchor, constant: 41),
            imgLogo.leadingAnchor.constraint(equalTo: vwHeader.leadingAnchor, constant: 32),
            
            stvContainer.topAnchor.constraint(equalTo: imgLogo.bottomAnchor, constant: 27),
            stvContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: imgLogo.leadingAnchor, multiplier: 0),
            
            lbReminder.topAnchor.constraint(equalTo: stvContainer.bottomAnchor, constant: 28),
            lbReminder.leadingAnchor.constraint(equalTo: vwHeader.leadingAnchor, constant: 32),
            
            btnMenu.trailingAnchor.constraint(equalTo: vwHeader.trailingAnchor, constant: -10),
            btnMenu.bottomAnchor.constraint(equalTo: stvContainer.bottomAnchor, constant: -30),
            
            //MARK: Scroll view body and content
            scvContainer.topAnchor.constraint(equalTo: vwHeader.bottomAnchor),
            scvContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scvContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scvContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            vwContainer.topAnchor.constraint(equalTo: scvContainer.topAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: scvContainer.trailingAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: scvContainer.leadingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: scvContainer.bottomAnchor),

            datePicker.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 34),
            datePicker.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -28),
            datePicker.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 28),
            
            stvDataOfTheDay.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 34),
            stvDataOfTheDay.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 32),
            
            tbvPeople.topAnchor.constraint(equalTo: stvDataOfTheDay.bottomAnchor, constant: 16),
            tbvPeople.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -28),
            tbvPeople.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 28),
            tbvPeople.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -20),
            tbvPeople.heightAnchor.constraint(equalToConstant: CGFloat(Double(accounts.count) * AccountCell.rowHeight)),
            
        ])
    }
}
 
extension AccountHomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard !accounts.isEmpty else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.reuseID, for: indexPath) as! AccountCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }

}


extension AccountHomeViewController {
    private func fetchData(){
        let tester = Account(rolType: .TesterQA, accountName: "Héctor González Martínez(Tú)")
        let devAndroid = Account(rolType: .DevelomentAndroid, accountName: "Christian Sandoval Estrada")
        let bussiness = Account(rolType: .BussinessAnalyst, accountName: "Fernanda Tamayo Rodríguez")
        let devBack = Account(rolType: .DevelomentBackend, accountName: "Octavio Javier Pérez Alarcón")
        let ScrumMaster = Account(rolType: .ScrumMaster, accountName: "Valeria Maldonado de León")
        let deviOS = Account(rolType: .DevelomentiOS, accountName: "Francisco Guzmán Hernández")
        let deviOS1 = Account(rolType: .DevelomentiOS, accountName: "samuel 1")
        
        accounts.append(tester)
        accounts.append(devAndroid)
        accounts.append(bussiness)
        accounts.append(devBack)
        accounts.append(ScrumMaster)
        accounts.append(deviOS)
        accounts.append(deviOS1)
        accounts.append(deviOS1)
        accounts.append(deviOS1)
        accounts.append(deviOS1)
    }
}
