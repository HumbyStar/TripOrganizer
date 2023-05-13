//
//  ViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTextField()
        configButtons()
        configPasswordView()
        
        emailTextField.text = "abc@gmail.com"
        passwordTextField.text = "123456"
        alert = Alert(controller: self)
    }
    
    @IBAction func tapToRecoverPassword(_ sender: UIButton) {
        let vc = UIStoryboard(name: RoutesIdentifier.RecoverViewController, bundle: nil).instantiateViewController(withIdentifier: RoutesIdentifier.RecoverViewController) as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tapToRegister(_ sender: UIButton) {
        let vc = UIStoryboard(name: RoutesIdentifier.RegisterViewController, bundle: nil).instantiateViewController(withIdentifier: RoutesIdentifier.RegisterViewController) as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tapToLogin(_ sender: Any) {
        
        let validateEmail = viewModel.validateEmail(emailTextField.text ?? "")
        let validatePassword = viewModel.validatePassword(passwordTextField.text ?? "")
        
        if validateEmail && validatePassword {
            let viewController = UIStoryboard(name: RoutesIdentifier.TabBarController, bundle: nil).instantiateViewController(withIdentifier: RoutesIdentifier.TabBarController) as? TabBarController
            resetTextField()
            navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
        } else {
            alert?.createAlert(title: MessageAlert.titleError.localized, message: MessageAlert.emailOrPaswordError.localized)
        }
        
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
        loginButton.setTitle(ButtonTitle.loginSuccess.localized, for: .normal)
        loginWithGoogleButton.clipsToBounds = true
        loginWithGoogleButton.layer.cornerRadius = 10
        loginWithGoogleButton.setTitle(ButtonTitle.loginGoogle.localized, for: .normal)
        loginWithAppleButton.clipsToBounds = true
        loginWithAppleButton.layer.cornerRadius = 10
        loginWithAppleButton.setTitle(ButtonTitle.loginApple.localized, for: .normal)
        recoverButton.setTitle(ButtonTitle.forgetPassword.localized, for: .normal)
        recoverButton.setTitleColor(.logoTextOrange, for: .normal)
        registerButton.setTitle(ButtonTitle.createAccount.localized, for: .normal)
        registerButton.setTitleColor(.logoTextOrange, for: .normal)
        configShadowButton(button: loginWithGoogleButton)
        configShadowButton(button: loginWithAppleButton)
        eyeButton.tintColor = .lightGray
        eyeButton.setImage(UIImage(systemName: ImagesAssets.blockedEye.rawValue), for: .normal)
        
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
        emailTextField.placeholder = TextfieldPlaceholder.email.localized
        passwordTextField.placeholder = TextfieldPlaceholder.password.localized
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
            eyeButton.setImage(UIImage(systemName: ImagesAssets.blockedEye.rawValue), for: .normal)
            passwordTextField.isSecureTextEntry = true
            viewModel.isEyeOpen = false
        } else {
            eyeButton.setImage(UIImage(systemName: ImagesAssets.eyes.rawValue), for: .normal)
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
