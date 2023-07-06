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
    private var fireStoreManager = FirestoreManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configTextField()
        configButton()
        configProtocols()
        configViews(view: passwordView)
        configViews(view: confirmPasswordView)
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    private func configViews(view: UIView) {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
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
    
    
    private func configTextFieldStandard(textField: UITextField, borderColor: UIColor , placeHolder: String, keyboardType: UIKeyboardType = .default) {
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
        configTextFieldStandard(textField: nameTextField, borderColor: .lightGray, placeHolder: Localized.namePlaceholder.localized)
        configTextFieldStandard(textField: emailTextField, borderColor: .lightGray, placeHolder: Localized.emailPlaceholder.localized, keyboardType: .emailAddress)
        configTextFieldStandard(textField: passwordTextField, borderColor: .lightGray, placeHolder: Localized.passwordPlaceholder.localized)
        configTextFieldStandard(textField: confirmPasswordTextField, borderColor: .lightGray, placeHolder: Localized.confirmPasswordPlaceholder.localized)
    }
    
    func registerNewUser() {
        guard let emailValid = emailTextField.text, let passwordValid = passwordTextField.text else {return}
        self.auth?.createUser(withEmail: emailValid, password: passwordValid, completion: { result, error in
            if error != nil {
                self.alert?.createAlert(title: Localized.errorTitle.localized, message: Localized.emailAlreadyExist)
            } else {
                if let idUser = result?.user.uid {
                    self.firestore?.collection(Localized.users.localized).document(idUser).setData([
                        Localized.nameTitle: self.nameTextField.text ?? "",
                        Localized.emailTitle: self.emailTextField.text ?? "",
                        Localized.id.localized: idUser
                    ])
                    
                    self.fireStoreManager.createUser(name: self.nameTextField.text ?? "", email: emailValid) { error in
                        if error != nil {
                            print(error?.localizedDescription as Any)
                        } else {
                            print("Firestore database criado")
                        }
                    }
                }
                self.alert?.createAlert(title: Localized.successTitle.localized, message: Localized.registrationSuccessMessage.localized,completion: {
                    self.login()
                })
            }
        })
    }
    
    func login() {
        let tabBarController = UIStoryboard(name: Localized.tabBarController, bundle: nil).instantiateViewController(withIdentifier: Localized.tabBarController) as? UITabBarController
        self.navigationController?.pushViewController(tabBarController ?? UITabBarController(), animated: true)
        
    }
    
    @IBAction func tapToShowPassword(_ sender: Any) {
        viewModel.getValidationtapToShowPasswordAndConfirmPassword(textField: passwordTextField, button: showPasswordButton)
    }
    
    
    @IBAction func tapToShowConfirmPassword(_ sender: Any) {
        viewModel.getValidationtapToShowPasswordAndConfirmPassword(textField: confirmPasswordTextField, button: showConfirmPasswordButton)
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
            self.registerNewUser()
        } else {
            self.alert?.createAlert(title: Localized.attention.localized, message: Localized.registrationErrorMessage.localized)
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
        viewModel.getConfigTextFieldShouldReturn(textField: textField, nameTextField: nameTextField, emailTextField: emailTextField, passwordTextField: passwordTextField, confirmPasswordTextField: confirmPasswordTextField)
    }
}

