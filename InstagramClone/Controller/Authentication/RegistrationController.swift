//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by Aaron Lee on 2021/03/19.
//

import UIKit
import Photos

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomtextField(placeholder: "Email", keyboardType: .emailAddress)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomtextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField = CustomtextField(placeholder: "Fullname")
    
    private let usernameTextField = CustomtextField(placeholder: "Username")

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.authenticationButton(title: "Sign Up")
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(
            normal: "Already have an account?",
            bold: "Log In"
        )
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Action
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullNameTextField {
            viewModel.fullname = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
    
    @objc func handleProfilePhotoSelect() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            showImagePicker()
        case .denied, .restricted:
            showImagePickerPermissionAlert()
        default:
            PHPhotoLibrary.requestAuthorization { [weak self] requestedStatus in
                
                guard let `self` = self else { return }
                
                switch requestedStatus {
                case .authorized:
                    self.showImagePicker()
                default:
                    self.showImagePickerPermissionAlert()
                }
                
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 32
        )
        
        let stack = UIStackView(
            arrangedSubviews: [
                emailTextField,
                passwordTextField,
                fullNameTextField,
                usernameTextField,
                signUpButton
            ]
        )
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(
            top: plusPhotoButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: 32
        )
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func showImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    func showImagePickerPermissionAlert() {
        let alert = UIAlertController(
            title: "Permission error!",
            message: "Photo library permission is required.",
            preferredStyle: .alert
        )
        
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                alert.dismiss(animated: true)
            }
        }
    }
    
}

// MARK: - FormViewModel

extension RegistrationController: FormViewModel {
    
    func updateForm() {
        signUpButton.isEnabled = viewModel.formIsValid
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) { [weak self] in
            guard let `self` = self else { return }
            self.signUpButton.backgroundColor = self.viewModel.buttonBackgroundColor
            self.signUpButton.setTitleColor(self.viewModel.buttonTitleColor, for: .normal)
        }
    }
       
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true)
        
    }
    
}
