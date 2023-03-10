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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configElements()
    }
    
    
    func configElements() {
        
        nameTextField.autocorrectionType = .no
        nameTextField.placeholder = "  Nome Completo"
        nameTextField.clipsToBounds = true
        nameTextField.layer.cornerRadius = 20
        nameTextField.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0)
        nameTextField.keyboardType = .default
        
        emailTextField.autocorrectionType = .no
        emailTextField.placeholder = "  E-mail"
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 20
        emailTextField.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0)
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.autocorrectionType = .no
        passwordTextField.placeholder = "  Senha"
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0)
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 20
        registerButton.backgroundColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        registerButton.setTitleColor(.white, for: .normal)
        
        alreadyHaveAccount.setTitleColor(.black,  for: .normal)
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        
    }
    
    @IBAction func alreadyHaveAccountPressed(_ sender: UIButton) {
        
        
    }
}
