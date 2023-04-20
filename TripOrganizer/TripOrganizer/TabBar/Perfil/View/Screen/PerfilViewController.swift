//
//  PerfilViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 16/03/23.
//

import UIKit

class PerfilViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configProfileImage()
        configImageConstraints()
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
    
    public func configImageConstraints() {
        let heightConstraint = profileImageView.heightAnchor.constraint(equalToConstant: 170)
        heightConstraint.isActive = true
        let widthConstraint = profileImageView.widthAnchor.constraint(equalToConstant: 170)
        widthConstraint.isActive = true
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: // iPhone SE (1st generation), iPhone 5, iPhone 5S, iPhone 5C
                heightConstraint.constant = 100
                widthConstraint.constant = 100
            case 1334, 1920, 2208: // iPhone 6, 6S, 7, 8, SE (2nd generation)
                heightConstraint.constant = 130
                widthConstraint.constant = 130
            case 2436, 2688, 1792: // iPhone X, XS, XR, 11 Pro, 12 mini, 11, 12
                heightConstraint.constant = 200
                widthConstraint.constant = 200
            case 2778: // IPhone 14 Plus
                heightConstraint.constant = 300
                widthConstraint.constant = 300
            case 2532: // iPhone 14
                heightConstraint.constant = 250
                widthConstraint.constant = 250
            case 2556: // IPhone 14 Pro
                heightConstraint.constant = 250
                widthConstraint.constant = 250
            default: // IPhone Pro Max
                heightConstraint.constant = 300
                widthConstraint.constant = 300 // fallback value for other devices
                
            }
        }
    }
    
    private func configProfileImage() {
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func configTextField(textfield: UITextField, text: String, keyboardType: UIKeyboardType, isSecure: Bool) {
        textfield.autocorrectionType = .no
        textfield.clipsToBounds = true
        textfield.layer.borderWidth = 3
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 10
        textfield.text = text
        textfield.keyboardType = keyboardType
        textfield.isSecureTextEntry = isSecure
    }
    
    private func configTextFields() {
        configTextField(textfield: nameTextField, text: "Caio Fabrini", keyboardType: .default, isSecure: false)
        configTextField(textfield: emailTextField, text: "caio.fabrini@backfrontacademy.com.br", keyboardType: .emailAddress, isSecure: false)
        configTextField(textfield: phoneTextField, text: "(13) 99234-8734", keyboardType: .numbersAndPunctuation, isSecure: false)
        configTextField(textfield: changePasswordTextField, text: "12345678", keyboardType: .default, isSecure: true)

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
        
        viewModel = PerfilViewModel(username: nameTextField.text ?? "",
                                    email: emailTextField.text ?? "",
                                    phone: phoneTextField.text ?? "",
                                    password: changePasswordTextField.text ?? "")
        
        
        if viewModel?.validateTextField() == true {
            self.alert?.createAlert(title: "Informações salvas.", message: "Informações salvas com sucesso.")
        } else {
            self.alert?.createAlert(title: "Preencha todos os campos.", message: "É necessário preencher todos os campos.")
        }
        
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        //let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        //navigationController?.pushViewController(ViewController(), animated: true)
     //   navigationController?.popToRootViewController(animated: true)
       // tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension PerfilViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.verde.cgColor
        
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

extension PerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
