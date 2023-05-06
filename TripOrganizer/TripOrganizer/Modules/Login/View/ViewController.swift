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
    @IBOutlet weak var loginWithIcloudButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var dontHaveAnAccountButton: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var eyeButton: UIButton!
    
    var isEyeOpen = false
    var viewModel: LoginViewModel = LoginViewModel()
    
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
    }
    
    @IBAction func tapToRecoverPassword(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecoverViewController", bundle: nil).instantiateViewController(withIdentifier: "RecoverViewController") as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tapToRegister(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterViewController", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tapToLogin(_ sender: Any) {
        let vc = UIStoryboard(name: "TabBarController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        loginButton.isEnabled = false
        emailTextField.text = ""
        passwordTextField.text = ""
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
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
        loginButton.isEnabled = false
        loginWithGoogleButton.clipsToBounds = true
        loginWithGoogleButton.layer.cornerRadius = 10
        loginWithIcloudButton.clipsToBounds = true
        loginWithIcloudButton.layer.cornerRadius = 10
        configShadowButton(button: loginWithGoogleButton)
        configShadowButton(button: loginWithIcloudButton)
        eyeButton.tintColor = .lightGray
        eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        
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
        if isEyeOpen {
            eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            isEyeOpen = false
        } else {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            isEyeOpen = true
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
        
        if emailTextField.hasText && passwordTextField.hasText {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
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
