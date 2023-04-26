//
//  ViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var entrarGoogleButton: UIButton!
    @IBOutlet weak var entrarIcloudButton: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var eyeButton: UIButton!
    
    // chamar a viewModel - fazer isso para conseguir acessar as propriedades da ViewModel
    var viewModel: LoginViewModel = LoginViewModel()
    
    // tirar a navigationbar (Parte superior da tela)
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextField()
        configButton()
        configView()
    }
    // fazer uma navegação para a tela de recorver
    @IBAction func esqueciSenhatappedButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecoverViewController", bundle: nil).instantiateViewController(withIdentifier: "RecoverViewController") as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    // fazer uma navegação para a tela de register
    @IBAction func registerTappedButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterController", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as? RegisterController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    // Ir para a tela TabBarController (Tela rootController da tabBar - Home)
    @IBAction func acessarButton(_ sender: Any) {
        let vc = UIStoryboard(name: "TabBarController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        entrarButton.isEnabled = false
        emailTextField.text = ""
        passwordTextField.text = ""
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    // confuguração para adicionar uma sombra
    private func configShadowButton(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 2
        button.layer.shouldRasterize = true
        button.layer.masksToBounds = false
        button.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // configurações para para o Botão
    private func configButton() {
        entrarButton.clipsToBounds = true
        entrarButton.layer.cornerRadius = 10
        entrarButton.isEnabled = false
        entrarGoogleButton.clipsToBounds = true
        entrarGoogleButton.layer.cornerRadius = 10
        entrarIcloudButton.clipsToBounds = true
        entrarIcloudButton.layer.cornerRadius = 10
        configShadowButton(button: entrarGoogleButton)
        configShadowButton(button: entrarIcloudButton)
        eyeButton.tintColor = .lightGray
        eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        
    }
    
    private func configView() {
        passwordView.backgroundColor = .clear
        passwordView.layer.cornerRadius = 10
        passwordView.clipsToBounds = true
        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    // Configurações que vou utilizar em outros textFields
    private func configTextFieldPadrao(textField: UITextField, keyboardType: UIKeyboardType = .emailAddress) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = keyboardType
        
    }
    // eu chamo minha função "configTextFieldPadrao"
    private func configTextField() {
        configProtocol()
        configTextFieldPadrao(textField: emailTextField)
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
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.logoGreen.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let emailText = emailTextField.text, let passwordText = passwordTextField.text, !emailText.isEmpty && !passwordText.isEmpty {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.lightGray.cgColor
            entrarButton.isEnabled = true
        } else {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.lightGray.cgColor
            entrarButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // validação para quando clicar no botão retorno ele ir para o proximo textField
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.lightGray.cgColor
        } else if textField == passwordTextField {
            // Se desejar, pode chamar uma função para validar o login aqui
            textField.resignFirstResponder()
        }
        return true
    }
}
