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
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alreadyHaveAccount: UIButton!
    
    var viewModel: RegisterViewModel = RegisterViewModel()
    
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
    
    private func configTextFieldPadrao(textField: UITextField,borderColor: UIColor , placeHolder: String, keyboardType: UIKeyboardType = .default) {
        textField.autocorrectionType = .no
        textField.clipsToBounds = true
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        textField.layer.cornerRadius = 10
        textField.placeholder = placeHolder
        textField.layer.borderColor = borderColor.cgColor
        textField.keyboardType = keyboardType
        textField.spellCheckingType = .no
    }
    
    private func configTextField() {
        configTextFieldPadrao(textField: nameTextField, borderColor: .lightGray, placeHolder: "Nome Completo")
        configTextFieldPadrao(textField: emailTextField, borderColor: .lightGray, placeHolder: "E-mail", keyboardType: .emailAddress)
        configTextFieldPadrao(textField: passwordTextField, borderColor: .lightGray, placeHolder: "Senha")
        //        confirmPasswordTextField.isSecureTextEntry = true
        configTextFieldPadrao(textField: confirmPasswordTextField, borderColor: .lightGray, placeHolder: "Confirmar Senha")
        //        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    public func validadeTextField() {
        if confirmPasswordTextField.text == passwordTextField.text {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
}

extension RegisterController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.verde.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == nameTextField {
            if textField.hasText {
                nameTextField.layer.borderWidth = 2
                nameTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
            
        }
        //        if textField.hasText {
        //            textField.layer.borderWidth = 2
        //            textField.layer.borderColor = UIColor.lightGray.cgColor
        //            registerButton.isEnabled = true
        //        } else {
        //            textField.layer.borderWidth = 1.5
        //            textField.layer.borderColor = UIColor.red.cgColor
        //            registerButton.isEnabled = false
        //        }
        //        validadeTextField()
        //    }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //        textField.resignFirstResponder()
            if textField == nameTextField {
                //MARK: quando eu clicar no return ele pular para o textField de Endereço
                emailTextField.becomeFirstResponder()
            }
            if textField == emailTextField {
                //MARK: Quando eu clicar no return ele pular paro o textField de senha
                passwordTextField.becomeFirstResponder()
            }
            if textField == passwordTextField {
                //MARK: Quando eu clicar no return ele pular paro o textField de confirmar Senha
                confirmPasswordTextField.becomeFirstResponder()
            }
            if textField == confirmPasswordTextField {
                //MARK: Quando eu clicar no return ele tem que
                textField.resignFirstResponder()
                confirmPasswordTextField.isEnabled = true
            }
            return true
        }
        
    }
}
