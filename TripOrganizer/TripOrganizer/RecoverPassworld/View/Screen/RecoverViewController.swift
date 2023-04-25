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
   private func configButton(){
        
        recuperarSenhaButton.layer.cornerRadius = 10
        recuperarSenhaButton.clipsToBounds = true
        recuperarSenhaButton.isEnabled = false
        
    }
   private func configTextField(){
       // Assinando o Protocolo do textField.
        emailTelaEsquecerSenhaTextField.delegate = self
    
        // Configurando o textField.
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
        textField.layer.borderColor = UIColor.logoGreen.cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        // MARK Essa validação faz com que se tiver um text no textField ele a abilita o botao, caso não tiver ele estará desabilitado.
        if textField.hasText == true {
            recuperarSenhaButton.isEnabled = true
        }else{
            recuperarSenhaButton.isEnabled = false
        }
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Faz com que a tecla "return" abaixe o teclado.
        textField.resignFirstResponder()
    }
    
    
}

