//
//  RecoverPasswordUIViewControler.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 08/03/23.
//

import UIKit

class RecoverViewController: UIViewController{
    
    var viewModel: RecoverPasswordViewModel = RecoverPasswordViewModel()
    var alert: Alert?
    
    @IBOutlet var appLogoImageView: UIImageView!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configTextField()
        configButton()
    }
    
   
    @IBAction func tapToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
   
    private func configButton(){
        recoverPasswordButton.layer.cornerRadius = 10
        recoverPasswordButton.clipsToBounds = true
        recoverPasswordButton.isEnabled = false
    }
    
   private func configTextField(){
        emailTextField.delegate = self
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func recoverPasswordButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: "", message: "Um Email de instrução foi enviado para sua caixa de entrada", completion: {
            self.navigationController?.popViewController(animated: true)
        })
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
        
        if textField.hasText == true {
            recoverPasswordButton.isEnabled = true
        }else{
            recoverPasswordButton.isEnabled = false
        }
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

