//
//  EditProfileViewController.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 16/12/21.
//

import UIKit

class EditProfileViewController: BaseViewController, UINavigationControllerDelegate {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameField: NormalTextField!
    @IBOutlet weak var emailField: NormalTextField!
    @IBOutlet weak var birthDateField: NormalTextField!
    @IBOutlet weak var phoneNumberField: NormalTextField!
    @IBOutlet weak var saveEditButton: LargeButton!
    
    
    // MARK: - Variables
    
    var imagePicker: ImagePicker!
    var viewModel = EditProfileViewModel()
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    
    
    // MARK: - Prepare UI Method
    
    func prepareUI() {
        viewModel.delegate = self
        
        
        // Navigation Bar Title
        self.title = "Edit Profile"
        
        
        // Profile Image View
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.systemGray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTapGestureRecognizer)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        // Normal Text Field
        fullNameField.textField.delegate = self
        emailField.textField.delegate = self
        birthDateField.textField.delegate = self
        phoneNumberField.textField.delegate = self
        
        // Bottom Border/Underline
        fullNameField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        emailField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        birthDateField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        phoneNumberField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        
        // Secured Text Field Placeholder Attributed String
        guard let placeholderFont = UIFont(name: "Nunito-Regular", size: 16) else {
            fatalError("""
                    Failed to load the "Nunito-Regular" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
        }
        
        fullNameField.textField.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        emailField.textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        birthDateField.textField.attributedPlaceholder = NSAttributedString(string: "Birth Date", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        phoneNumberField.textField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        
        // Keyboard Control
        /* oldPasswordTextField.textField.becomeFirstResponder() */ // Commented until further decision
        
        // Tap Gesture Recognizer for dismissing keyboard on tap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.tap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Update Password Button
        saveEditButton.buttonOutlet.layer.cornerRadius = 5
        
        // Update Password Button Attributed Title
        guard let saveEditButtonFont = UIFont(name: "Nunito-SemiBold", size: 17) else {
            fatalError("""
                    Failed to load the "Nunito-SemiBold" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
        }
        
        let saveEditButtonAttributes = NSAttributedString(string: "Save Edit", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: saveEditButtonFont)])
        
        saveEditButton.buttonOutlet.setAttributedTitle(saveEditButtonAttributes, for: .normal)
        saveEditButton.buttonOutlet.setAttributedTitle(saveEditButtonAttributes, for: .highlighted)
        saveEditButton.buttonOutlet.setAttributedTitle(saveEditButtonAttributes, for: .focused)
        saveEditButton.buttonOutlet.tintColor = UIColor.white
        
        if fullNameField.textField.text!.isEmpty &&
            emailField.textField.text!.isEmpty &&
            birthDateField.textField.text!.isEmpty &&
            phoneNumberField.textField.text!.isEmpty {
            saveEditButton.buttonOutlet.isUserInteractionEnabled = false
            saveEditButton.buttonOutlet.backgroundColor = UIColor(named: "Disabled Button")!
        }
        
        saveEditButton.buttonOutlet.addTarget(self, action: #selector(saveEdit), for: .touchUpInside)
    }
    
    
    // MARK: - Tap Gesture Recognizer
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.imagePicker.present(from: tappedImage)
    }
    
    @objc func saveEdit(button: UIButton) {
        self.updateData()
//        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - Image Picker Delegate

extension EditProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.profileImageView.image = image
    }
}


// MARK: - Text Field Delegate

extension EditProfileViewController: UITextFieldDelegate {
    // Keyboard Control
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameField.textField {
            emailField.textField.becomeFirstResponder()
            emailField.textField.addBottomBorder(color: UIColor(named: "Button Blue")!)
        }
        if textField == emailField.textField {
            birthDateField.textField.becomeFirstResponder()
            birthDateField.textField.addBottomBorder(color: UIColor(named: "Button Blue")!)
        }
        if textField == birthDateField.textField {
            phoneNumberField.textField.becomeFirstResponder()
            phoneNumberField.textField.addBottomBorder(color: UIColor(named: "Button Blue")!)
        }
        if textField == phoneNumberField.textField {
            phoneNumberField.textField.resignFirstResponder()
        }
    
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addBottomBorder(color: UIColor(named: "Button Blue")!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if fullNameField.textField.text!.isEmpty || emailField.textField.text!.isEmpty || birthDateField.textField.text!.isEmpty || phoneNumberField.textField.text!.isEmpty {
            saveEditButton.buttonOutlet.isUserInteractionEnabled = false
            saveEditButton.buttonOutlet.backgroundColor = UIColor(named: "Disabled Button")!
        } else {
            saveEditButton.buttonOutlet.isUserInteractionEnabled = true
            saveEditButton.buttonOutlet.backgroundColor = UIColor(named: "Button Blue")!
        }

        return true
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


// MARK: - Profile View Model Delegate

extension EditProfileViewController: editProfileViewModelDelegate {
    func onSuccessPatch() {
        self.removeSpinner()
        let alertController = UIAlertController(title: "Success" , message: "Profile Updated!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func onErrorPatch() {
        self.removeSpinner()
        let alertController = UIAlertController(title: "Error" , message: "Edit Profile Failed!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}



// MARK: - Methods

extension EditProfileViewController {
    func updateData() {
        self.showParentSpinner()
        viewModel.editProfile(fullName: fullNameField.textField.text ?? "", email: emailField.textField.text ?? "", birthDate: birthDateField.textField.text ?? "", phoneNumber: phoneNumberField.textField.text ?? "")
    }
}
