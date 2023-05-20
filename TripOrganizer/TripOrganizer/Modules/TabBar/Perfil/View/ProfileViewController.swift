//
//  PerfilViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 16/03/23.
//

import UIKit

enum ProfileImageSelected: String {
    case profileImage = "ProfileImageSelected"
}

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var changePasswordLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var changePasswordTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var changeProfileImageButton: UIButton!
    
    var alert: Alert?
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configProfileImage()
        configTextFieldDelegates()
        configTextFields()
        configLabel()
        configButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = min(profileImageView.frame.width, profileImageView.frame.height) / 2
        profileImageView.clipsToBounds = true
    }
    
    private func configTextFieldDelegates() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneTextField.delegate = self
        self.changePasswordTextField.delegate = self
    }
    
    private func configProfileImage() {
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.logoGreen.cgColor
    }
    
    private func configDefaultTextField(textfield: UITextField, text: String, keyboardType: UIKeyboardType, isSecure: Bool) {
        textfield.autocorrectionType = .no
        textfield.clipsToBounds = true
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 10
        textfield.text = text
        textfield.keyboardType = keyboardType
        textfield.isSecureTextEntry = isSecure
        textfield.spellCheckingType = .no
    }
    
    private func configTextFields() {
        configDefaultTextField(textfield: nameTextField, text: String.namePlaceholderProfile.localized, keyboardType: .default, isSecure: false)
        configDefaultTextField(textfield: emailTextField, text: String.emailPlaceholderProfile.localized, keyboardType: .emailAddress, isSecure: false)
        configDefaultTextField(textfield: phoneTextField, text: String.titlePhoneProfileUser.localized, keyboardType: .numbersAndPunctuation, isSecure: false)
        configDefaultTextField(textfield: changePasswordTextField, text: String.titleChangePasswordProfile.localized, keyboardType: .default, isSecure: true)
    }
    
    private func configLabel() {
        nameLabel.text = String.titleNameProfile.localized
        emailLabel.text = String.tileEmailProfile.localized
        phoneLabel.text = String.titlePhoneProfile.localized
        changePasswordLabel.text = String.titleChangePasswordProfile.localized
    }
    
    private func configButton() {
        changeProfileImageButton.setTitle(String.buttonTitleChangeImage.localized, for: .normal)
        saveButton.setTitle(String.saveButtonTitle.localized, for: .normal)
        exitButton.setTitle(String.exitButtonTitle.localized, for: .normal)
    }
    
    @IBAction func changeProfileImageButtonPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: "", message: String.saveDataProfile.localized, completion: {
            self.navigationController?.popViewController(animated: true)
        })
        
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.logoGreen.cgColor
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.hasText {
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor.red.cgColor
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            changePasswordTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        if let selectedImage = info[.originalImage] as? UIImage {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ProfileImageSelected.profileImage.rawValue) , object: selectedImage)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
