//
//  PerfilViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 16/03/23.
//

import UIKit

class PerfilViewController: UIViewController {
    
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
    var viewModel: PerfilViewModel?
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        configProfileImage()
        configTextFieldDelegates()
        configTextFields()
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
        configDefaultTextField(textfield: nameTextField, text: "Caio Fabrini", keyboardType: .default, isSecure: false)
        configDefaultTextField(textfield: emailTextField, text: "caio.fabrini@backfrontacademy.com.br", keyboardType: .emailAddress, isSecure: false)
        configDefaultTextField(textfield: phoneTextField, text: "(13) 99234-8734", keyboardType: .numbersAndPunctuation, isSecure: false)
        configDefaultTextField(textfield: changePasswordTextField, text: "12345678", keyboardType: .default, isSecure: true)

    }
    
    @IBAction func changeProfileImageButtonPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    @objc func keyboardWillShow(notification: Notification) {
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }

        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height + tabBarHeight
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        viewModel = PerfilViewModel(username: nameTextField.text ?? "",
                                    email: emailTextField.text ?? "",
                                    phone: phoneTextField.text ?? "",
                                    password: changePasswordTextField.text ?? "")
        
        
        if viewModel?.validateTextField() == true {
            self.alert?.createAlert(title: "Trip Organizer", message: "Informações salvas com sucesso.")
        } else {
            self.alert?.createAlert(title: "Trip Organizer", message: "É necessário preencher todos os campos.")
        }
        
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        tabBarController?.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension PerfilViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.logoGreen.cgColor
        
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.hasText {
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor.red.cgColor
        }
        
        self.activeTextField = nil
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

extension PerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        if let selectedImage = info[.originalImage] as? UIImage {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileImageSelected") , object: selectedImage)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
