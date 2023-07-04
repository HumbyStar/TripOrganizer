//
//  RecoverPasswordUIViewControler.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 08/03/23.
//

import UIKit
import Firebase

class RecoverViewController: UIViewController{
    
    private var alert: Alert?
    private let viewModel = RecoverPasswordViewModel()
    
    @IBOutlet var appLogoImageView: UIImageView!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configTextField()
        configButton()
        configLabel()
    }
    
    @IBAction func tapToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func configButton(){
        recoverPasswordButton.layer.cornerRadius = 10
        recoverPasswordButton.clipsToBounds = true
        recoverPasswordButton.setTitle(Localized.tapToRegisterButtonTitle.localized, for: .normal)
    }
    
    private func configLabel(){
        descriptionLabel.text = Localized.confirmEmailDescription
    }
    
    private func configTextField(){
        emailTextField.delegate = self
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.placeholder = Localized.emailPlaceholder.localized
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func recoverPasswordButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            return
        }
        
        Auth.auth().fetchSignInMethods(forEmail: email) { [weak self] signInMethods, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Erro ao verificar os métodos de login:", error.localizedDescription)
                self.alert?.createAlert(title: Localized.errorTitle.localized, message: Localized.errorSendingEmail.localized)
            } else if let signInMethods = signInMethods, signInMethods.isEmpty {
                self.alert?.createAlert(title: Localized.errorTitle.localized, message: Localized.emailNotRegistered.localized)
            } else {
                Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Erro ao enviar o link de redefinição de senha:", error.localizedDescription)
                        self.alert?.createAlert(title: Localized.errorTitle.localized, message: Localized.errorSendingEmail.localized)
                    } else {
                        self.alert?.createAlert(title: Localized.sentEmail.localized, message: Localized.EmailToResetPassword.localized)
                    }
                }
            }
        }
        
    }
}

extension RecoverViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.logoGreen.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

