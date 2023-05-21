//
//  RecoverPasswordUIViewControler.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 08/03/23.
//

import UIKit

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
        recoverPasswordButton.setTitle(String.tapToRegisterButtonTitle.localized, for: .normal)
    }
    
    private func configLabel(){
        descriptionLabel.text = String.confirmEmailDescription
    }
    
    private func configTextField(){
        emailTextField.delegate = self
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.placeholder = String.emailPlaceholder.localized
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func recoverPasswordButtonPressed(_ sender: UIButton) {
        guard let emailValue = emailTextField.text else {return}
        if viewModel.validateConfirmEmail(emailValue) {
            alert?.createAlert(title: String.errorTitle.localized, message: String.invalidEmail.localized)
        } else {
            alert?.createAlert(title: String.successTitle.localized, message: String.instructionEmailSent.localized , completion: {
                self.navigationController?.popViewController(animated: true)
            })
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

