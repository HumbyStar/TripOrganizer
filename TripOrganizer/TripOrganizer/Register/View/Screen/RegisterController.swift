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
    @IBOutlet weak var exibSenhaButton: UIButton!
    @IBOutlet weak var exibConfirSenhaButton: UIButton!
    
    var viewModel: RegisterViewModel?
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel()
        alert = Alert(controller: self)
        configTextField()
        configButton()
        configProtocols()
    }
    
    private func configButton() {
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = UIColor.verde
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
        textField.layer.borderColor = UIColor.verde.cgColor
        textField.layer.cornerRadius = 10
        textField.placeholder = placeHolder
        textField.layer.borderColor = borderColor.cgColor
        textField.keyboardType = keyboardType
        textField.spellCheckingType = .no
        nameTextField.autocapitalizationType = .words
    }
    
    private func configTextField() {
        configTextFieldPadrao(textField: nameTextField, borderColor: .lightGray, placeHolder: "Nome Completo")
        configTextFieldPadrao(textField: emailTextField, borderColor: .lightGray, placeHolder: "E-mail", keyboardType: .emailAddress)
        configTextFieldPadrao(textField: passwordTextField, borderColor: .lightGray, placeHolder: "Senha")
        configTextFieldPadrao(textField: confirmPasswordTextField, borderColor: .lightGray, placeHolder: "Confirmar Senha")
    }
    
    
    @IBAction func tappedExibSenhaButton(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        if passwordTextField.isSecureTextEntry {
            exibSenhaButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            exibSenhaButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    
    @IBAction func tappedExibconfirSenhaButton(_ sender: Any) {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
        
        if confirmPasswordTextField.isSecureTextEntry {
            exibConfirSenhaButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            exibConfirSenhaButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    
    @IBAction func voltarButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if nameTextField.hasText && emailTextField.hasText && passwordTextField.hasText && confirmPasswordTextField.hasText {
            if confirmPasswordTextField.text == passwordTextField.text {
                alert?.createAlert(title: "TripOrganizer", message: "Cadastro efetuado com sucesso!", completion: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
            } else {
                alert?.createAlert(title: "TripOrganizer", message: "Ambas as senha devem ser iguais!")
                confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
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
        // MARK: Essa validação faz com que caso o textField selecionado fica verde e caso saia do mesmo, volte a ficar em lightGray e que se todos os textField estiverem com textos abilitara o botal de resgistrar.
        if nameTextField.hasText == true && emailTextField.hasText == true && passwordTextField.hasText == true && confirmPasswordTextField.hasText == true {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.lightGray.cgColor
            registerButton.isEnabled = true
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.lightGray.cgColor
            //            registerButton.isEnabled = false
        }
        // MARK: Essa validação tem o objetivo de fazer com que os textos do textField de senha e confirmar senha, teram que ser iguais, se nao for o textField confirmar senha ficara com uma borda vermelha e o botao de registrar não vai abilitar.
        if textField == confirmPasswordTextField || textField == passwordTextField {
            if confirmPasswordTextField.text == passwordTextField.text {
                confirmPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
                passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            //MARK: quando eu clicar no return ele pular para o textField de Endereço
            emailTextField.becomeFirstResponder()
            
        } else if textField == emailTextField {
            //MARK: Quando eu clicar no return ele pular paro o textField de senha
            passwordTextField.becomeFirstResponder()
            
        } else if textField == passwordTextField {
            //MARK: Quando eu clicar no return ele pular paro o textField de confirmar Senha
            confirmPasswordTextField.becomeFirstResponder()
            
        } else {
            //MARK: Quando eu clicar no return ele tem que
            textField.resignFirstResponder()
        }
        return true
        
    }
}

