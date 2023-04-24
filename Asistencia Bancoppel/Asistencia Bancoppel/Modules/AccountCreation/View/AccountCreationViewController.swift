//
//  AccountCreationViewController.swift
//  Asistencia Bancoppel
//
//  Created by Luis Diaz on 13/04/23.
//

import Foundation
import UIKit


internal class AccountCreationViewController: UIViewController {
    private var pages: [UIViewController] = []
    private let viewModel = AccountCreationViewModel()
    private var model = AccountCreationModel()
    private var credential: String?
    
    lazy var vwContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ivwLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoCoppelAsistenciaColored")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var pvwcPager: UIPageViewController = {
        let pagerView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pagerView.view.translatesAutoresizingMaskIntoConstraints = false
        pagerView.delegate = self
        pagerView.dataSource = self
        return pagerView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTapped()
        
        setComponents()
        setAutolayout()
        setPager()
        bind()
    }
    
    
    private func setComponents() {
        self.view.addSubview(vwContainer)
        vwContainer.addSubview(ivwLogo)
        vwContainer.addSubview(pvwcPager.view)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            vwContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            vwContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            ivwLogo.topAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.topAnchor, constant: Dimensions.margin50),
            ivwLogo.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin80),
            ivwLogo.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin80),
            ivwLogo.heightAnchor.constraint(equalToConstant: (50 * DeviceSize.size.getMultiplier())),
            
            pvwcPager.view.topAnchor.constraint(equalTo: ivwLogo.bottomAnchor, constant: Dimensions.margin30),
            pvwcPager.view.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: Dimensions.margin30),
            pvwcPager.view.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -Dimensions.margin30),
            pvwcPager.view.bottomAnchor.constraint(equalTo: vwContainer.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.margin50),
        ])
    }
    
    private func setPager() {
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = GlobalConstants.BancoppelColors.blueBex7
        pageControl.pageIndicatorTintColor = GlobalConstants.BancoppelColors.grayBex3
        
        let viewController1 = AccountCreationPageViewController()
        viewController1.delegate = self
        let viewController2 = PersonalDataPageViewController()
        viewController2.delegate = self
        let viewController3 = LastStepPageViewController()
        viewController3.delegate = self
        
        pages.append(viewController1)
        pages.append(viewController2)
        pages.append(viewController3)
        pvwcPager.setViewControllers([pages[0]], direction: .forward, animated: true)
    }
}



extension AccountCreationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        /*guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        
        return pages[currentIndex - 1]*/
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        /*guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < (pages.count - 1) else {
            return nil
        }
        
        return pages[currentIndex + 1]*/
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let currentVC = pvwcPager.viewControllers?.first {
            return pages.firstIndex(of: currentVC) ?? 0
        } else {
            return 0
        }
    }
    
    private func bind(){
        self.viewModel.accountCreationObaservable.observe = { errorMessage in
            CustomLoader.hide()

            guard let nonNilErrorMessage = errorMessage else {
                self.showAlert(message: "Cuenta creada con éxito.")
                return
            }
            
            self.showAlert(message: nonNilErrorMessage ?? "", isError: true)
        }
    }
    
    private func showAlert(message: String, isError: Bool = false) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: isError ? "Error" : "Información",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                guard !isError else {
                    return
                }
                self.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}



extension AccountCreationViewController: AccountCreationPageDelegate {
    func notifyAccountCreationPageNext(email: String, credential: String) {
        model.email = email.lowercased()
        self.credential = credential
        
        pvwcPager.setViewControllers([pages[1]], direction: .forward, animated: true)
    }
}

extension AccountCreationViewController: PersonalDataPageDelegate {
    func notifyPersonalDataNext(name: String, firstLastname: String, secondLastname: String, birthDate: String, cellphone: String) {
        model.name = name
        model.lastName1 = firstLastname
        model.lastName2 = secondLastname
        model.birthDay = birthDate
        model.phone = cellphone
        
        pvwcPager.setViewControllers([pages[2]], direction: .forward, animated: true)
    }
}

extension AccountCreationViewController: LastStepPageViewDelegate {
    func notifyGetUsername() -> String {
        let userFullname = ((model.name ?? "") + " " + (model.lastName1 ?? "") + " " + (model.lastName2 ?? ""))
        return userFullname
    }
    
    func notifyLastStepPageFinish(charge: String, team: String, collaboratorNumber: Int, photo: UIImage) {
        model.position = charge
        model.team = team
        model.employee = collaboratorNumber

        CustomLoader.show()
        viewModel.registerAccount(accountRequest: model, credential: credential ?? "", photo: photo)
    }
}
