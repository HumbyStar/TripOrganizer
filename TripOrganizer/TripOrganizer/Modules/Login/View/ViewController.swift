//
//  ViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var appLogoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWithGoogleButton: UIButton!
    @IBOutlet weak var loginWithAppleButton: UIButton!
    @IBOutlet var recoverButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var eyeButton: UIButton!
    
   
    var viewModel: LoginViewModel = LoginViewModel()
    private var alert: Alert?
    private var auth: Auth?
    private var firestore: Firestore?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTextField()
        configButtons()
        configPasswordView()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        alert = Alert(controller: self)
    }
    
    @IBAction func tapToRecoverPassword(_ sender: UIButton) {
        let vc = UIStoryboard(name: String.RecoverViewController, bundle: nil).instantiateViewController(withIdentifier: String.RecoverViewController) as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tapToRegister(_ sender: UIButton) {
        let vc = UIStoryboard(name: String.RegisterViewController, bundle: nil).instantiateViewController(withIdentifier: String.RegisterViewController) as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tapToLogin(_ sender: Any) {
        
        let validateEmail = viewModel.validateEmail(emailTextField.text ?? "")
        let validatePassword = viewModel.validatePassword(passwordTextField.text ?? "")
        
        if validateEmail && validatePassword {
            validateFieldToLogin()
        } else {
            alert?.createAlert(title: String.titleError, message: String.emailOrPaswordError)
        }
        
    }
    
    private func validateFieldToLogin() {
        self.auth?.signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { user, error in
            if error != nil {
                self.alert?.createAlert(title: "Atenção", message: "Dados incorretos")
            } else {
                if user == nil {
                    self.alert?.createAlert(title: "Atenção", message: "Tivemos um problema inesperado, tente novamente mais tarde")
                } else {
                    self.alert?.createAlert(title: "", message: "Login efetuado com sucesso",completion: {
                        let viewController = UIStoryboard(name: String.TabBarController, bundle: nil).instantiateViewController(withIdentifier: String.TabBarController) as? TabBarController
                        self.resetTextField()
                        self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
                    })
                }
            }
        })
    }
    
    private func resetTextField() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func configShadowButton(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 2
        button.layer.shouldRasterize = true
        button.layer.masksToBounds = false
        button.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func configButtons() {
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle(String.loginSuccess, for: .normal)
        loginWithGoogleButton.clipsToBounds = true
        loginWithGoogleButton.layer.cornerRadius = 10
        loginWithGoogleButton.setTitle(String.loginGoogle, for: .normal)
        loginWithAppleButton.clipsToBounds = true
        loginWithAppleButton.layer.cornerRadius = 10
        loginWithAppleButton.setTitle(String.loginApple, for: .normal)
        recoverButton.setTitle(String.forgetPassword, for: .normal)
        recoverButton.setTitleColor(.logoTextOrange, for: .normal)
        registerButton.setTitle(String.createAccount, for: .normal)
        registerButton.setTitleColor(.logoTextOrange, for: .normal)
        configShadowButton(button: loginWithGoogleButton)
        configShadowButton(button: loginWithAppleButton)
        eyeButton.tintColor = .lightGray
        eyeButton.setImage(UIImage(systemName: String.blockedEye), for: .normal)
        
    }
    
    private func configPasswordView() {
        passwordView.backgroundColor = .clear
        passwordView.layer.cornerRadius = 10
        passwordView.clipsToBounds = true
        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    private func configTextField() {
        configProtocol()
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.autocorrectionType = .no
        emailTextField.spellCheckingType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = String.email.localized
        passwordTextField.placeholder = String.password.localized
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .none
        
    }
    
    private func configProtocol() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func tappedEyeButton(_ sender: UIButton) {
        if viewModel.isEyeOpen {
            eyeButton.setImage(UIImage(systemName: String.blockedEye), for: .normal)
            passwordTextField.isSecureTextEntry = true
            viewModel.isEyeOpen = false
        } else {
            eyeButton.setImage(UIImage(systemName: String.eyes), for: .normal)
            passwordTextField.isSecureTextEntry = false
            viewModel.isEyeOpen = true
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderWidth = 3
            emailTextField.layer.borderColor = UIColor.logoGreen.cgColor
        } else {
            passwordView.layer.borderWidth = 3
            passwordView.layer.borderColor = UIColor.logoGreen.cgColor
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
