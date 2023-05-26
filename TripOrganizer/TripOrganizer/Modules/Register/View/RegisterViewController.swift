//
//  RegisterViewController.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 08/03/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alreadyHaveAccountButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showConfirmPasswordButton: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    private var alert: Alert?
    private let viewModel = RegisterViewModel()
    private var auth: Auth?
    private var firestore: Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configTextField()
        configButton()
        configProtocols()
        configViews()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    private func configViews() {
        passwordView.backgroundColor = .clear
        passwordView.layer.cornerRadius = 10
        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        confirmPasswordView.backgroundColor = .clear
        confirmPasswordView.layer.cornerRadius = 10
        confirmPasswordView.layer.borderWidth = 2
        confirmPasswordView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func configButton() {
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = UIColor.logoGreen
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitle(Localized.registerButtonTitle.localized, for: .normal)
        alreadyHaveAccountButton.setTitle(Localized.alreadyHaveAccountButtonTitle.localized, for: .normal)
    }
    
    private func configProtocols(){
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    
    private func configTextFieldPadrao(textField: UITextField, borderColor: UIColor , placeHolder: String, keyboardType: UIKeyboardType = .default) {
        if textField == passwordTextField || textField == confirmPasswordTextField {
            textField.layer.borderWidth = 0
            textField.borderStyle = .none
        } else {
            textField.layer.borderWidth = 2
        }
        textField.autocorrectionType = .no
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.logoGreen.cgColor
        textField.layer.cornerRadius = 10
        textField.placeholder = placeHolder
        textField.layer.borderColor = borderColor.cgColor
        textField.keyboardType = keyboardType
        textField.spellCheckingType = .no
        nameTextField.autocapitalizationType = .words
    }
    
    private func configTextField() {
        configTextFieldPadrao(textField: nameTextField, borderColor: .lightGray, placeHolder: Localized.namePlaceholder.localized)
        configTextFieldPadrao(textField: emailTextField, borderColor: .lightGray, placeHolder: Localized.emailPlaceholder.localized, keyboardType: .emailAddress)
        configTextFieldPadrao(textField: passwordTextField, borderColor: .lightGray, placeHolder: Localized.passwordPlaceholder.localized)
        configTextFieldPadrao(textField: confirmPasswordTextField, borderColor: .lightGray, placeHolder: Localized.confirmPasswordPlaceholder.localized)
    }
    
    func registerNewUser() {
        
        guard let emailValid = emailTextField.text, let passwordValid = passwordTextField.text else {return}
        self.auth?.createUser(withEmail: emailValid, password: passwordValid, completion: { result, error in
            if error != nil {
                self.alert?.createAlert(title: Localized.attention.localized, message: Localized.registrationErrorMessage.localized)
            } else {
                if let idUser = result?.user.uid {
                    self.firestore?.collection(Localized.users.localized).document(idUser).setData([
                        Localized.nameTitle: self.nameTextField.text ?? "",
                        Localized.emailTitle: self.emailTextField.text ?? "",
                        Localized.id.localized: idUser
                    ])
                }
            }
        })
    }
    
    @IBAction func tapToShowPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(systemName: Localized.blockedEye), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: Localized.eye), for: .normal)
        }
    }
    
    
    @IBAction func tapToShowConfirmPassword(_ sender: Any) {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
        
        if confirmPasswordTextField.isSecureTextEntry {
            showConfirmPasswordButton.setImage(UIImage(systemName: Localized.blockedEye), for: .normal)
        } else {
            showConfirmPasswordButton.setImage(UIImage(systemName: Localized.eye), for: .normal)
        }
    }
    
    @IBAction func tapToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        guard let nameValue = nameTextField.text,
                      let emailValue = emailTextField.text,
                      let passwordValue = passwordTextField.text,
                      let confirmPasswordValue = confirmPasswordTextField.text
                else {return}

                if viewModel.validateForms(name: nameValue, email: emailValue, password: passwordValue, confirmPassword: confirmPasswordValue) {
                    alert?.createAlert(title: Localized.successTitle, message: Localized.registrationSuccessMessage, completion: {

                        self.registerNewUser()
                        let tabBarController = UIStoryboard(name: Localized.tabBarController, bundle: nil).instantiateViewController(withIdentifier: Localized.tabBarController) as? UITabBarController
                        self.navigationController?.pushViewController(tabBarController ?? UITabBarController(), animated: true)
                    })
                } else {
                    alert?.createAlert(title: Localized.errorTitle, message: Localized.registrationErrorMessage)
                }
    }
    
    @IBAction func alreadyHaveAccountPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
            case confirmPasswordTextField:
                confirmPasswordView.layer.borderWidth = 2
                confirmPasswordView.layer.borderColor = UIColor.logoGreen.cgColor
            case passwordTextField:
                passwordView.layer.borderWidth = 2
                passwordView.layer.borderColor = UIColor.logoGreen.cgColor
            default:
                textField.layer.borderWidth = 2
                textField.layer.borderColor = UIColor.logoGreen.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let nameValue = nameTextField.text,
              let emailValue = emailTextField.text,
              let passwordValue = passwordTextField.text,
              let confirmPasswordValue = confirmPasswordTextField.text
        else {return}
        
        switch textField {
            
        case nameTextField:
            if viewModel.validateName(nameValue) {
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                textField.layer.borderWidth = 2
                textField.layer.borderColor = UIColor.lightGray.cgColor
            }
            
        case emailTextField:
            if viewModel.validateEmail(emailValue) {
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                textField.layer.borderWidth = 2
                textField.layer.borderColor = UIColor.lightGray.cgColor
            }
            
        case passwordTextField:
            if viewModel.validatePassword(passwordValue) {
                passwordView.layer.borderColor = UIColor.red.cgColor
            } else {
                passwordView.layer.borderWidth = 2
                passwordView.layer.borderColor = UIColor.gray.cgColor
            }
            if viewModel.validateConfirmPassword(confirmPasswordValue) {
                confirmPasswordView.layer.borderColor = UIColor.red.cgColor
            } else {
                confirmPasswordView.layer.borderColor = UIColor.gray.cgColor
            }
            
        default:
            if viewModel.validateConfirmPassword(confirmPasswordValue) {
                confirmPasswordView.layer.borderColor = UIColor.red.cgColor
            } else {
                confirmPasswordView.layer.borderWidth = 2
                confirmPasswordView.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

