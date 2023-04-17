//
//  RecoverPasswordUIViewControler.swift
//  TripOrganizer
//
//  Created by Mikael Rodrigues on 08/03/23.
//

import UIKit

class RecoverViewController: UIViewController{
    var viewModel: RecoverPasswordViewModel = RecoverPasswordViewModel()
    
    @IBOutlet weak var recuperarSenhaButton: UIButton!
    @IBOutlet weak var emailTelaEsquecerSenhaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextField()
        configButton()
    }
    
   
    @IBAction func voltarButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func configButton(){
        
        recuperarSenhaButton.layer.cornerRadius = 10
        recuperarSenhaButton.clipsToBounds = true
        
        
    }
    func configTextField(){
        emailTelaEsquecerSenhaTextField.delegate = self
        
        emailTelaEsquecerSenhaTextField.layer.borderWidth = 2
        emailTelaEsquecerSenhaTextField.layer.borderColor = UIColor.lightGray.cgColor
//        emailTelaEsquecerSenhaTextField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
        emailTelaEsquecerSenhaTextField.clipsToBounds = true
        emailTelaEsquecerSenhaTextField.layer.cornerRadius = 10
        emailTelaEsquecerSenhaTextField.keyboardType = .emailAddress
        emailTelaEsquecerSenhaTextField.autocorrectionType = .no
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension RecoverViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor(red: 112/255, green: 156/255, blue: 149/255, alpha: 1).cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
}

