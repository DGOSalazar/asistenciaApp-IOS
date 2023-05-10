//
//  UploadPhotoButton.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 15/04/23.
//

import Foundation
import UIKit
import Photos


internal protocol UploadPhotoButtonDelegate: AnyObject {
    func notifyPhotoSelected(photo: UIImage)
}


internal class UploadPhotoButton: UIView {
    private var buttonSize: CGFloat = 99
    private weak var presenter: UIViewController?
    private weak var delegate: UploadPhotoButtonDelegate?
    private var changeImageSize: CGFloat = (30 * DeviceSize.size.getMultiplier())
    
    private lazy var buttonContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    private lazy var changeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "roload_icon")
        imageView.tintColor = GlobalConstants.BancoppelColors.blueBex7
        imageView.layer.cornerRadius = (changeImageSize/2.0)
        return imageView
    }()
    
    private lazy var previewImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var uploadImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = GlobalConstants.BancoppelColors.blueBex7
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    private lazy var uploadTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoRegular(ofSize: 14)
        label.textColor = GlobalConstants.BancoppelColors.grayBex5
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(999), for: .vertical)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    internal init(presenter: UIViewController,
                  delegate: UploadPhotoButtonDelegate?,
                  buttonSize: CGFloat = 140,
                  title: String = "Cargar foto",
                  icon: UIImage? = nil,
                  showShadow: Bool = true,
                  borderColor: UIColor = GlobalConstants.BancoppelColors.yellowBex3,
                  borderWidth: CGFloat = 10) {
        super.init(frame: .zero)
        
        self.presenter = presenter
        self.delegate = delegate
        self.buttonSize = buttonSize
        self.uploadTitleLabel.text = title
        self.uploadImageView.image = icon ?? UIImage(named: "share_media_icon")
        self.buttonContainerView.layer.borderColor = borderColor.cgColor
        self.buttonContainerView.layer.cornerRadius = (buttonSize / 2)
        self.buttonContainerView.layer.borderWidth = borderWidth
        self.previewImageView.layer.cornerRadius = (buttonSize / 2)
        self.buttonContainerView.layer.shadowColor = (showShadow ? UIColor.black.cgColor : UIColor.clear.cgColor)
        self.buttonContainerView.clipsToBounds = !showShadow
        self.addTarget(self, action: #selector(self.showGallery))
        
        self.setComponents()
        self.setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setComponents() {
        self.addSubview(buttonContainerView)
        self.addSubview(changeImageView)
        
        buttonContainerView.addSubview(previewImageView)
        buttonContainerView.addSubview(uploadImageView)
        buttonContainerView.addSubview(uploadTitleLabel)
        
        self.bringSubviewToFront(changeImageView)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            buttonContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonContainerView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            buttonContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonContainerView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            buttonContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttonContainerView.heightAnchor.constraint(equalToConstant: self.buttonSize),
            buttonContainerView.widthAnchor.constraint(equalToConstant: self.buttonSize),
            
            changeImageView.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor, constant: (self.buttonSize/3.5)),
            changeImageView.centerXAnchor.constraint(equalTo: buttonContainerView.centerXAnchor, constant: (self.buttonSize/3.5)),
            changeImageView.widthAnchor.constraint(equalToConstant: changeImageSize),
            changeImageView.heightAnchor.constraint(equalToConstant: changeImageSize),
            
            previewImageView.topAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor),
            
            uploadImageView.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 20),
            uploadImageView.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 20),
            uploadImageView.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -20),
            
            uploadTitleLabel.topAnchor.constraint(equalTo: uploadImageView.bottomAnchor),
            uploadTitleLabel.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 20),
            uploadTitleLabel.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -20),
            uploadTitleLabel.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -30),
        ])
    }
    
    internal func addTarget(_ target: Any?, action: Selector?) {
        DispatchQueue.main.async {
            if let nonNilGestureRecognizer = self.buttonContainerView.gestureRecognizers?.first {
                self.buttonContainerView.removeGestureRecognizer(nonNilGestureRecognizer)
            }
            let gesture = UITapGestureRecognizer(target: target, action: action)
            gesture.numberOfTapsRequired = 1
            self.buttonContainerView.addGestureRecognizer(gesture)
        }
    }
    
    func setPreviewImage(image: UIImage) {
        DispatchQueue.main.async {
            self.previewImageView.image = image
            self.previewImageView.isHidden = false
            self.uploadTitleLabel.isHidden = true
            self.uploadImageView.isHidden = true
            self.changeImageView.isHidden = false
        }
    }
    
    @objc private func showGallery() {
        self.checkGalleryPermissions {
            DispatchQueue.main.async {
                guard let nonNilPresenter = self.presenter else {
                    return
                }
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.modalPresentationStyle = .overFullScreen
                    
                    nonNilPresenter.present(imagePicker, animated: true)
                }
            }
        }
    }
    
    private func checkGalleryPermissions(completion: @escaping () -> ()) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .authorized {
                    completion()
                } else {
                    self.showSettings()
                }
            })
        case .restricted:
            self.showSettings()
        case .denied:
            self.showSettings()
        case .authorized:
            completion()
        case .limited:
            self.showSettings()
        @unknown default:
            self.showSettings()
        }
    }
    
    private func showSettings() {
        DispatchQueue.main.async {
            guard let nonNilPresenter = self.presenter else {
                return
            }
            
            let alert = UIAlertController(title: "Error", message: "Habilite los permisos para acceder a la galería", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Configuración", style: .default, handler: { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(settingsUrl, completionHandler: { (_) in })
            }))
            
            nonNilPresenter.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension UploadPhotoButton: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        let assetPath = info[UIImagePickerController.InfoKey.imageURL] as? NSURL
        guard (assetPath?.absoluteString?.lowercased().hasSuffix("jpg") == true ||
               assetPath?.absoluteString?.lowercased().hasSuffix("jpeg") == true ||
               assetPath?.absoluteString?.lowercased().hasSuffix("png") == true) else {
            return
        }

        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        self.setPreviewImage(image: image)
        
        self.delegate?.notifyPhotoSelected(photo: image)
    }
}
