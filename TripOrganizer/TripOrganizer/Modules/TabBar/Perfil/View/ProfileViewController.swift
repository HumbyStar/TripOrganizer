//
//  PerfilViewController.swift
//  TripOrganizer
//
//  Created by Humberto Rodrigues on 16/03/23.
//

import UIKit

enum ProfileImageSelected: String {
    case profileImage = "ProfileImageSelected"
}

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var changeProfileImageButton: UIButton!
    
    var alert: Alert?
    var profileViewModel: ProfileViewModel = ProfileViewModel()
    private var fireStoreManager = FirestoreManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        configProfileImage()
        configTextFieldDelegates()
        configTextFields()
        configLabel()
        configButton()
        getUserProfileInfo()
    }
    
    
    private func getUserProfileInfo() {
        fireStoreManager.getObjectData(collection: "user", forObjectType: User.self) { result in
            switch result {
            case .success(let sucess):
                let user = sucess
                self.nameTextField.text = user.name
                if let imageData = user.profileImage {
                    self.profileImageView.image = UIImage(data: imageData)
                } else {
                    let defaultImage = UIImage(systemName: "person")
                    self.profileImageView.image = defaultImage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileViewModel.getCircleBorderImageView(profileImageView: profileImageView)
    }
    
    private func configTextFieldDelegates() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
    }
    
    private func configProfileImage() {
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.logoGreen.cgColor
    }
    
    private func configDefaultTextField(textfield: UITextField, text: String, keyboardType: UIKeyboardType, isSecure: Bool) {
        textfield.autocorrectionType = .no
        textfield.clipsToBounds = true
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 10
        textfield.text = text
        textfield.keyboardType = keyboardType
        textfield.isSecureTextEntry = isSecure
        textfield.spellCheckingType = .no
    }
    
    private func configTextFields() {
        configDefaultTextField(textfield: nameTextField, text: Localized.namePlaceholderProfile.localized, keyboardType: .default, isSecure: false)
        configDefaultTextField(textfield: emailTextField, text: Localized.emailPlaceholderProfile.localized, keyboardType: .emailAddress, isSecure: false)
    }
    
    private func configLabel() {
        nameLabel.text = Localized.nameTitle.localized
        emailLabel.text = Localized.emailTitle.localized
        
    }
    
    private func configButton() {
        changeProfileImageButton.setTitle(Localized.changeImageButtonTitle.localized, for: .normal)
        saveButton.setTitle(Localized.saveButtonTitle.localized, for: .normal)
        exitButton.setTitle(Localized.exitButtonTitle.localized, for: .normal)
    }
    
    @IBAction func changeProfileImageButtonPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        alert?.createAlert(title: "", message: Localized.dataChangedSuccessfully.localized, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.logoGreen.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.hasText {
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor.red.cgColor
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileViewModel.getConfigTextFielShouldReturn(textField: textField, nameTextField: nameTextField, emailTextField: emailTextField)
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        if let selectedImage = info[.originalImage] as? UIImage {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ProfileImageSelected.profileImage.rawValue) , object: selectedImage)
            
            guard let imageData = selectedImage.jpegData(compressionQuality: .leastNonzeroMagnitude) else { return }
            
            fireStoreManager.addProfileImage(image: imageData) { result in
                
                switch result {
                case .success:
                    print("Imagem adicionado com sucesso!")
                case .failure(let error):
                    print("Erro ao adicionar Imagem: \(error.localizedDescription)")
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
