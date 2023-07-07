//
//  ViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: "60868162820-0nrf4k2ngjdvecbcol6s2hfg7tbegaiv.apps.googleusercontent.com")
    
    @IBOutlet var appLogoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInWithGoogleButton: UIButton!
    @IBOutlet weak var signInWithAppleButton: UIButton!
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
        configButtons(button: signInWithGoogleButton)
        configButtons(button: loginButton)
        configPasswordView()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        alert = Alert(controller: self)
        
    }
    
    
    @IBAction func tappedLoginWithGoogleButton(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }

            let user = signInResult.user // here i got access to the user
            
            let viewController = UIStoryboard(name: Localized.tabBarController, bundle: nil).instantiateViewController(withIdentifier: Localized.tabBarController) as? TabBarController
            self.resetTextField()
            self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)

        }
        
    }
    
    @IBAction func tapToRecoverPassword(_ sender: UIButton) {
        let vc = UIStoryboard(name: Localized.recoverViewController, bundle: nil).instantiateViewController(withIdentifier: Localized.recoverViewController) as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    @IBAction func tapToRegister(_ sender: UIButton) {
        let vc = UIStoryboard(name: Localized.registerViewController, bundle: nil).instantiateViewController(withIdentifier: Localized.registerViewController) as? RegisterViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tapToLogin(_ sender: Any) {
        
        let validateEmail = viewModel.validateEmail(emailTextField.text ?? "")
        let validatePassword = viewModel.validatePassword(passwordTextField.text ?? "")
        
        if validateEmail && validatePassword {
            validateFieldToLogin()
        } else {
            alert?.createAlert(title: Localized.errorTitle, message: Localized.invalidEmailPassword)
        }
        
    }
    
    private func validateFieldToLogin() {
        self.auth?.signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { user, error in
            if error != nil {
                self.alert?.createAlert(title: Localized.attention.localized, message: Localized.invalidData.localized)
            } else {
                if user == nil {
                    self.alert?.createAlert(title: Localized.attention.localized, message: Localized.loginErroMessage.localized)
                } else {
                    let viewController = UIStoryboard(name: Localized.tabBarController, bundle: nil).instantiateViewController(withIdentifier: Localized.tabBarController) as? TabBarController
                    self.resetTextField()
                    self.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
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
    
    private func configButtons(button: UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        loginButton.setTitle(Localized.loginSuccessButtonTitle.localized, for: .normal)
        signInWithGoogleButton.setTitle(Localized.signInWithGoogleButtonTitle.localized, for: .normal)
        recoverButton.setTitle(Localized.forgetPasswordButtonTitle, for: .normal)
        recoverButton.setTitleColor(.logoTextOrange, for: .normal)
        registerButton.setTitle(Localized.createAccountButtonTitle.localized, for: .normal)
        registerButton.setTitleColor(.logoTextOrange, for: .normal)
        configShadowButton(button: signInWithGoogleButton)
        eyeButton.tintColor = .lightGray
        eyeButton.setImage(UIImage(systemName: Localized.blockedEye), for: .normal)
        
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
        emailTextField.placeholder = Localized.emailPlaceholder.localized
        passwordTextField.placeholder = Localized.passwordPlaceholder.localized
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
        viewModel.getValidationtappedEyeButton(passwordTextField: passwordTextField, eyeButton: eyeButton)
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
        viewModel.getTextFieldShouldReturn(textField: textField, emailTextField: emailTextField, passwordTextField: passwordTextField)
    }
}
