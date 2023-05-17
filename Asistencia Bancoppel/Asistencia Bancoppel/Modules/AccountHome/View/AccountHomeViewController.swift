//
//  AccountHomeViewController.swift
//  Asistencia Bancoppel
//
//  Created by Samuel Fuentes Navarrete on 24/02/23.
//

import UIKit


protocol AccountHomeViewDelegate: AnyObject {
    func notifyCurrentUserData(data: UserAttendanceDataModel)
}


class AccountHomeViewController: UIViewController {
    internal weak var delegate: AccountHomeViewDelegate?
    private var viewModel = AccountViewModel()
    internal var email: String = ""
    private var currentUserData: UserAttendanceDataModel?
    private var usersData: [UserAttendanceDataModel] = []
    private var usersAttendingToday: [UserAttendanceDataModel] = []
    private var usersTableHeigthConstraint = NSLayoutConstraint()
    
    private var  isConfirm: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        initComponents()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CustomLoader.show()
        viewModel.getUsersData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private lazy var navigationBarView: TopNavigationBarView = {
        let nav = TopNavigationBarView(title: "",
                                       titleFont: .robotoBold(ofSize: 28),
                                       style: .one,
                                       showBankIcon: true,
                                       showBackButton: false,
                                       showRightButton: true)
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        return nav
    }()
    
    private let buttonFloatConfirm: ConfirmAsistenciaButton = {
        let buttonConfirm = ConfirmAsistenciaButton()
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        return buttonConfirm
    }()
 
    
    private let vwHeader : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalConstants.BancoppelColors.blueBex7
        return view
    }()
    

    
    private let lbDate: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let text1 = "Hoy es ".attributed(color: .white,
                                         font: .robotoRegular(ofSize: 14))
        let text2 = "\(Date().getDayNameAndDayString().capitalized + " de " + Date().getMonthName().capitalized)".attributed(color: .white,
                                                                           font: .robotoBold(ofSize: 14))
        let text3 = " de \(Date().getYear()).".attributed(color: .white,
                                                          font: .robotoRegular(ofSize: 14))
        text1.append(text2)
        text1.append(text3)
        
        label.attributedText = text1
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let lbReminder: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recuerda registrarte para la próxima semana."
        label.font = .robotoMedium(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
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
    
    
    lazy var customCalendarView: CustomCalendarView = {
        let calendar = CustomCalendarView(profilePhoto: nil,
                                          profileEmail: self.email,
                                          delegate: self)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
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
        label.font = .robotoBold(ofSize: 24)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let lbNumberOfPeople: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex10
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    private lazy var tbvPeople: UITableView = {
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

    
    func initComponents(){
        addComponents()
        setAutoLayout()
        buttonFloatConfirm.isHidden = isConfirm
        bind()
    }
    
    func addComponents(){
        view.addSubview(navigationBarView)
        view.addSubview(vwHeader)
        vwHeader.addSubview(lbDate)
        vwHeader.addSubview(lbReminder)
        view.addSubview(scvContainer)
        scvContainer.addSubview(vwContainer)
        scvContainer.addSubview(buttonFloatConfirm)
        vwContainer.addSubview(customCalendarView)
        vwContainer.addSubview(stvDataOfTheDay)
        stvDataOfTheDay.addArrangedSubview(lbPersonsInTheOffice)
        stvDataOfTheDay.addArrangedSubview(lbNumberOfPeople)
        vwContainer.addSubview(tbvPeople)
    }
    
    func setAutoLayout(){
        vwContainer.widthAnchor.constraint(equalTo: scvContainer.widthAnchor).isActive = true

        usersTableHeigthConstraint = tbvPeople.heightAnchor.constraint(equalToConstant: CGFloat(Double(usersData.count) * AccountCell.rowHeight))
        
        NSLayoutConstraint.activate([
            //MARK: Header with your data
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
 
            vwHeader.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            vwHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vwHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
   
            lbDate.topAnchor.constraint(equalTo: vwHeader.topAnchor),
            lbDate.leadingAnchor.constraint(equalTo: vwHeader.leadingAnchor, constant: Dimensions.margin25),
            lbDate.trailingAnchor.constraint(equalTo: vwHeader.trailingAnchor, constant: -Dimensions.margin25),
            
            lbReminder.topAnchor.constraint(equalTo: lbDate.bottomAnchor, constant: Dimensions.margin25),
            lbReminder.leadingAnchor.constraint(equalTo: vwHeader.leadingAnchor, constant: Dimensions.margin25),
            lbReminder.trailingAnchor.constraint(equalTo: vwHeader.trailingAnchor, constant: -Dimensions.margin25),
            lbReminder.bottomAnchor.constraint(equalTo: vwHeader.bottomAnchor, constant: -Dimensions.margin25),

            //MARK: Scroll view body and content
            scvContainer.topAnchor.constraint(equalTo: vwHeader.bottomAnchor),
            scvContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scvContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scvContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            buttonFloatConfirm.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            buttonFloatConfirm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            vwContainer.topAnchor.constraint(equalTo: scvContainer.topAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: scvContainer.trailingAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: scvContainer.leadingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: scvContainer.bottomAnchor),

            customCalendarView.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: Dimensions.margin25),
            customCalendarView.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin25),
            customCalendarView.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin25),
            
            stvDataOfTheDay.topAnchor.constraint(equalTo: customCalendarView.bottomAnchor, constant: Dimensions.margin25),
            stvDataOfTheDay.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin25),
            
            tbvPeople.topAnchor.constraint(equalTo: stvDataOfTheDay.bottomAnchor, constant: Dimensions.margin15),
            tbvPeople.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin25),
            tbvPeople.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin25),
            tbvPeople.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -Dimensions.margin25),
            usersTableHeigthConstraint
        ])
    }
    
    private func updateTableHeight() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.usersTableHeigthConstraint.constant = CGFloat(Double(self.usersAttendingToday.count) * AccountCell.rowHeight)
            }
        }
    }
    
    private func bind() {
        self.viewModel.dayAttendanceObservable.observe = { [weak self] response in
            guard let nonNilResponse = response else {
                self?.showAlert(message: "Invalid response", isError: true)
                return
            }
            
            let (daysData, error) = nonNilResponse
            
            guard let nonNilData = daysData else {
                self?.showAlert(message: error ?? "", isError: true)
                return
            }
            
            CustomLoader.hide()
            self?.customCalendarView.setDaysData(data: nonNilData)
            
            
            let auxTodaysDate = Date()
            let currentDayAttendance = nonNilData.first(where: {
                guard let dataAux = $0.currentDay?.toDate() else {
                    return false
                }
                return dataAux.isThisSame(toDate: auxTodaysDate, toGranularity: .day)
            })
            
            guard let nonNilCurrentDayAttendance = currentDayAttendance else {
                self?.showTodaysUsersAttendance(data: nil)
                return
            }
            
            self?.showTodaysUsersAttendance(data: nonNilCurrentDayAttendance)
        }
        
        
        self.viewModel.usersObservable.observe = { (response) in
            guard let nonNilResponse = response else {
                self.showAlert(message: "Invalid response", isError: true)
                return
            }
            
            let (accountData, error) = nonNilResponse
            
            guard let nonNilData = accountData else {
                self.showAlert(message: error ?? "", isError: true)
                return
            }
            
            let currentUser = nonNilData.filter { $0.email.lowercased() == self.email.lowercased() }
            
            guard let nonNilCurrentUser = currentUser.first else {
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let auxImage = UIImage(fromURL: nonNilCurrentUser.profilePhotoURL)
                
                if let nonNilIndex = self.usersData.firstIndex(of: nonNilCurrentUser), !self.usersData.isEmpty {
                    self.usersData[nonNilIndex].profilePhoto = auxImage
                    
                    self.currentUserData = self.usersData[nonNilIndex]
                    self.delegate?.notifyCurrentUserData(data: self.usersData[nonNilIndex])
                }
                
                self.customCalendarView.profilePhoto = auxImage ?? UIImage()
                self.viewModel.getDayAttendance()
            }
            
            self.currentUserData = nonNilCurrentUser
            self.navigationBarView.setTitle(title: "¡Hola, \(nonNilCurrentUser.name)!")
            self.usersData = nonNilData
            
            
        }
    }
    
    
    private func showTodaysUsersAttendance(data: DayAttendanceModel?) {
        DispatchQueue.main.async {
            var auxUsersAttendingToday: [UserAttendanceDataModel] = []
            for currentDayEmail in data?.email ?? [] {
                if let user = self.usersData.first(where: { $0.email == currentDayEmail }) {
                    auxUsersAttendingToday.append(user)
                }
            }
            auxUsersAttendingToday = auxUsersAttendingToday.sorted { (initial, next) -> Bool in
                guard initial.email != self.email else {
                    return true
                }
                return (initial.name > next.name)
            }
             
            if let currentUser = auxUsersAttendingToday.first, auxUsersAttendingToday.count > 0, currentUser.email == self.email {
                auxUsersAttendingToday[0].fullname = "\(auxUsersAttendingToday[0].fullname) (Tú)"
            }
            
            
            self.usersAttendingToday = auxUsersAttendingToday
            self.lbNumberOfPeople.text = "\(self.usersAttendingToday.count) \(self.usersAttendingToday.count == 1 ? "Asistente." : "Asistentes.")"
            self.updateTableHeight()
            self.tbvPeople.reloadData()
            self.downloadAttendingUsersPhoto()
        }
    }
    
    private func downloadAttendingUsersPhoto() {
        DispatchQueue.global(qos: .userInitiated).async {
            for index in 0 ..< self.usersAttendingToday.count {
                guard let nonNilIndex = self.usersData.firstIndex(of: self.usersAttendingToday[index]) else {
                    continue
                }
                
                guard self.usersData[nonNilIndex].profilePhoto == nil else {
                    continue
                }
                
                let _ = UIImage(fromURL: self.usersData[nonNilIndex].profilePhotoURL) { photo in
                    self.usersData[nonNilIndex].profilePhoto = photo
                    self.usersAttendingToday[index].profilePhoto = photo
                    
                    DispatchQueue.main.async {
                        self.tbvPeople.reloadData()
                    }
                }
            }
        }
    }
    
    private func showAlert(message: String, isError: Bool = false) {
        DispatchQueue.main.async {
            CustomLoader.hide()
            let alert = UIAlertController(title: isError ? "Error" : "Información",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                guard isError else {
                    return
                }
                self.navigationController?.popToRootViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
 
extension AccountHomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !usersAttendingToday.isEmpty else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.reuseID, for: indexPath) as? AccountCell
        
        guard let nonNilCell = cell else { return UITableViewCell() }
        
        nonNilCell.configure(with: usersAttendingToday[indexPath.row])

        return nonNilCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersAttendingToday.count
    }

}


extension AccountHomeViewController: CustomCalendarViewDelegate {
    func notifyCellTapped(cellData: CustomCalendarDayModel?) {
        print(cellData)
        let detailCalendarViewController = DetailCalendarViewController()
        self.navigationController?.pushViewController(detailCalendarViewController, animated: true)
    }
}
