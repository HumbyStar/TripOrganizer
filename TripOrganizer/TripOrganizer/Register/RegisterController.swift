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
    }
    
    private func configTextField() {
        
   //     nameTextField.autocorrectionType = .no
//        nameTextField.placeholder = "  Nome Completo"
     //   nameTextField.clipsToBounds = true
//        nameTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
//        nameTextField.layer.borderWidth = 2
//        nameTextField.layer.cornerRadius = 10
//        nameTextField.keyboardType = .default
        configTextFieldPadrao(textField: nameTextField, borderColor: .lightGray, placeHolder: "Nome Completo")
        
//        emailTextField.autocorrectionType = .no
//        emailTextField.placeholder = "  E-mail"
//        emailTextField.clipsToBounds = true
//        emailTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
//        emailTextField.layer.borderWidth = 2
//        emailTextField.layer.cornerRadius = 10
//        emailTextField.keyboardType = .emailAddress
        configTextFieldPadrao(textField: emailTextField, borderColor: .lightGray, placeHolder: "E-mail", keyboardType: .emailAddress)
        
//        passwordTextField.autocorrectionType = .no
//        passwordTextField.placeholder = "  Senha"
//        passwordTextField.clipsToBounds = true
//        passwordTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
//        passwordTextField.layer.borderWidth = 2
//        passwordTextField.layer.cornerRadius = 10
//        passwordTextField.keyboardType = .default
        //passwordTextField.isSecureTextEntry = true
        configTextFieldPadrao(textField: passwordTextField, borderColor: .lightGray, placeHolder: "Senha")
        
//        confirmPasswordTextField.autocorrectionType = .no
//        confirmPasswordTextField.placeholder = "  Comfirmar Senha"
//       confirmPasswordTextField.clipsToBounds = true
//        confirmPasswordTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
//        confirmPasswordTextField.layer.borderWidth = 2
//        confirmPasswordTextField.layer.cornerRadius = 10
//        confirmPasswordTextField.keyboardType = .default
        //confirmPasswordTextField.isSecureTextEntry = true
        configTextFieldPadrao(textField: confirmPasswordTextField, borderColor: .lightGray, placeHolder: "Confirmar Senha")
        
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
        textField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
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
//if textField == nameTextField {
////MARK: quando eu clicar no return ele pular para o textField de Endereço
//    nameTextField.becomeFirstResponder()
//}
//if textField == enderecoTextField {
////MARK: Quando eu clicar no return ele pular paro o textField de senha
//    enderecoTextField.becomeFirstResponder()
//}
//if textField == passwordTextField {
////MARK: Quando eu clicar no return ele pular paro o textField de confirmar Senha
//    passwordTextField.becomeFirstResponder()
//}
//if textField == confirmPasswordTextField {
////MARK: Quando eu clicar no return ele tem que
//    confirmPasswordTextField.resignFirstResponder()
//    confirmPasswordTextField.isEnabled = true
//}
//return true
//}
