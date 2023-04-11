//
//  ViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var entrarGoogleButton: UIButton!
    @IBOutlet weak var entrarIcloudButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextField()
        configButton()
    }
    
    @IBAction func esqueciSenhatappedButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecoverViewController", bundle: nil).instantiateViewController(withIdentifier: "RecoverViewController") as? RecoverViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func registerTappedButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterController", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as? RegisterController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func acessarButton(_ sender: Any) {
        let vc = UIStoryboard(name: "TabBarController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    
    
    private func configButton() {
        entrarButton.clipsToBounds = true
        entrarButton.layer.cornerRadius = 10
//        entrarButton.isEnabled = false
        
        entrarGoogleButton.clipsToBounds = true
        entrarGoogleButton.layer.cornerRadius = 10
        
        entrarIcloudButton.clipsToBounds = true
        entrarIcloudButton.layer.cornerRadius = 10
    }
    
    private func configTextField() {
        emailTextField.delegate = self
        passWordTextField.delegate = self
        
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        
        passWordTextField.layer.borderWidth = 2
        passWordTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        passWordTextField.clipsToBounds = true
        passWordTextField.layer.cornerRadius = 10
        passWordTextField.autocorrectionType = .no
        passWordTextField.isSecureTextEntry = true
//        passWordTextField.textContentType = .newPassword
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
