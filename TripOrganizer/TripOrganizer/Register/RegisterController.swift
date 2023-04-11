//
//  RegisterViewController.swift
//  TripOrganizer
//
//  Created by Felipe Augusto Correia on 08/03/23.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alreadyHaveAccount: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextField()
        configButton()
        configProtocols()
    }
    
    private func configButton() {
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1.0)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.isEnabled = false
        alreadyHaveAccount.setTitleColor(.black,  for: .normal)
    }
    
    private func configProtocols(){
       
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    
    private func configTextField() {
        
        nameTextField.autocorrectionType = .no
        nameTextField.placeholder = "  Nome Completo"
        nameTextField.clipsToBounds = true
        nameTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.cornerRadius = 10
        nameTextField.keyboardType = .default
        nameTextField.autocorrectionType = .no
        
        emailTextField.autocorrectionType = .no
        emailTextField.placeholder = "  E-mail"
        emailTextField.clipsToBounds = true
        emailTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.autocorrectionType = .no
        passwordTextField.placeholder = "  Senha"
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.keyboardType = .default
        //passwordTextField.isSecureTextEntry = true
        
        confirmPasswordTextField.autocorrectionType = .no
        confirmPasswordTextField.placeholder = "  Comfirmar Senha"
        confirmPasswordTextField.clipsToBounds = true
        confirmPasswordTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        confirmPasswordTextField.layer.borderWidth = 2
        confirmPasswordTextField.layer.cornerRadius = 10
        confirmPasswordTextField.keyboardType = .default
        //confirmPasswordTextField.isSecureTextEntry = true
        
    }
    
    
    @IBAction func voltarButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func alreadyHaveAccountPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        
        if textField.hasText == true && confirmPasswordTextField.text == passwordTextField.text {
            registerButton.isEnabled = true
        }else{
            registerButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
