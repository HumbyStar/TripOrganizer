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
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    var viewModel: RegisterViewModel?
    var alert: Alert?
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        alert = Alert(controller: self)
        configTextField()
        configButton()
        configProtocols()
        configViews()
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
        registerButton.isEnabled = false
        alreadyHaveAccount.setTitleColor(.black,  for: .normal)
    }
    
    private func configProtocols(){
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    
    private func configTextFieldPadrao(textField: UITextField, borderColor: UIColor , placeHolder: String, keyboardType: UIKeyboardType = .default) {
        textField.autocorrectionType = .no
        textField.clipsToBounds = true
        if textField == passwordTextField || textField == confirmPasswordTextField {
            textField.layer.borderWidth = 0
            textField.borderStyle = .none
        } else {
            textField.layer.borderWidth = 2
        }
    
       // textField.borderStyle = .none
        textField.layer.borderColor = UIColor.logoGreen.cgColor
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
    
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
           return
        }

        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
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
                confirmPasswordView.layer.borderColor = UIColor.red.cgColor
                passwordView.layer.borderColor = UIColor.red.cgColor
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
        textField.layer.borderColor = UIColor.logoGreen.cgColor
        
        if textField == passwordTextField {
            passwordView.layer.borderWidth = 3
            passwordView.layer.borderColor = UIColor.logoGreen.cgColor
            textField.layer.borderWidth = .zero
//            textField.borderStyle = .none
        } else if textField == confirmPasswordTextField {
            confirmPasswordView.layer.borderWidth = 3
            confirmPasswordView.layer.borderColor = UIColor.logoGreen.cgColor
            textField.layer.borderWidth = .zero
//            textField.borderStyle = .none
        }
        
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // MARK: Essa validação faz com que caso o textField selecionado fica verde e caso saia do mesmo, volte a ficar em lightGray e que se todos os textField estiverem com textos abilitara o botal de resgistrar.
        
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        confirmPasswordView.layer.borderWidth = 2
        confirmPasswordView.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = .zero
        confirmPasswordTextField.layer.borderWidth = .zero
        
        
        if nameTextField.hasText && emailTextField.hasText && passwordTextField.hasText && confirmPasswordTextField.hasText {
            registerButton.isEnabled = true
            if passwordTextField.text != confirmPasswordTextField.text {
                passwordView.layer.borderWidth = 2
                passwordView.layer.borderColor = UIColor.red.cgColor
                confirmPasswordView.layer.borderWidth = 2
                confirmPasswordView.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
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

