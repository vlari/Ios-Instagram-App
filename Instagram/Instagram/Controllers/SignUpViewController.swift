//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Obed Garcia on 28/10/21.
//

import UIKit
import SafariServices

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let profilePrictureImage: UIImageView = {
       let view = UIImageView()
        view.tintColor = .lightGray
        view.image = UIImage(systemName: "person.circle")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 46
        return view
    }()
    private let usernameField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = "Username"
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        view.keyboardType = .default
        view.returnKeyType = .next
        view.autocorrectionType = .no
        return view
    }()
    private let emailField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = "Email"
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        view.keyboardType = .emailAddress
        view.returnKeyType = .next
        view.autocorrectionType = .no
        return view
    }()
    private let passwordField: CustomTextField = {
        let view = CustomTextField()
        view.placeholder = "Create Password"
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        view.isSecureTextEntry = true
        view.keyboardType = .default
        view.returnKeyType = .next
        view.autocorrectionType = .no
        return view
    }()
    private let signUpButton: UIButton = {
      let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    private let termsButton: UIButton = {
      let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    private let privacyButton: UIButton = {
      let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    public var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        view.backgroundColor = .systemBackground
        addSubViews()
        usernameField.delegate = self
        passwordField.delegate = self
        setupHandlers()
        addImageTapGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 90
        
        profilePrictureImage.frame = CGRect(x: (view.width - imageSize)/2, y: view.safeAreaInsets.top + 15, width: imageSize, height: imageSize)
        usernameField.frame = CGRect(x: 25, y: profilePrictureImage.bottom+20, width: view.width-50, height: 50)
        emailField.frame = CGRect(x: 25, y: usernameField.bottom+10, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signUpButton.frame = CGRect(x: 35, y: passwordField.bottom+20, width: view.width-70, height: 50)
        termsButton.frame = CGRect(x: 35, y: signUpButton.bottom+50, width: view.width-70, height: 40)
        privacyButton.frame = CGRect(x: 35, y: termsButton.bottom+10, width: view.width-70, height: 40)
    }
    
    private func addSubViews() {
        view.addSubview(profilePrictureImage)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(usernameField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }

    private func setupHandlers() {
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc func didTapSignUp() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              username.trimmingCharacters(in: .alphanumerics).isEmpty,
              username.count >= 8,
              password.count >= 8 else {
            return
        }
        
        let profilePicture = profilePrictureImage.image?.pngData()
        
        // Auth manager
        AuthManager.shared.signUp(email: email,
                                  username: username,
                                  profilePicture: profilePicture,
                                  password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.username, forKey: "username")
                    self.navigationController?.popToRootViewController(animated: true)
                    self.completion?()
                    break
                case .failure(let error):
                    print("Error while trying to sign up \(error)")
                }
            }
        }
    }
    
    @objc func didTapTerms() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacy() {
        guard let url = URL(string: "https://www.instagram.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignUp()
        }
        
        return true
    }
    
    private func addImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profilePrictureImage.isUserInteractionEnabled = true
        profilePrictureImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapImage() {
        let sheet = UIAlertController(title: "Profile Picture", message: "Set a picture to help your friends find you", preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType  = .camera
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType  = .photoLibrary
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        
        present(sheet, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        profilePrictureImage.image = image
    }
    
}
