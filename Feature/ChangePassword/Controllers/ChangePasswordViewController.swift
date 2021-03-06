//
//  ChangePasswordViewController.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 10/12/21.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var oldPasswordTextField: SecuredTextField!
    @IBOutlet weak var newPasswordTextField: SecuredTextField!
    @IBOutlet weak var confirmPasswordTextField: SecuredTextField!
    @IBOutlet weak var updatePasswordButton: LargeButton!
    
    
    // MARK: - Variables
    
    var viewModel = ChangePasswordViewModel()
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    
    
    // MARK: - Prepare UI Method
    
    func prepareUI() {
        // View Model Delegate
        viewModel.delegate = self
        
        
        // Navigation Bar Title
        self.title = "Change Password"
        
        
        // Secured Text Field
        oldPasswordTextField.textField.delegate = self
        newPasswordTextField.textField.delegate = self
        confirmPasswordTextField.textField.delegate = self
        
        // Bottom Border/Underline
        oldPasswordTextField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        newPasswordTextField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        confirmPasswordTextField.textField.addBottomBorder(color: UIColor(named: "NonActive Text")!)
        
        // Secured Text Field Placeholder Attributed String
        guard let placeholderFont = UIFont(name: "Nunito-Regular", size: 16) else {
            fatalError("""
                    Failed to load the "Nunito-Regular" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
        }
        
        oldPasswordTextField.textField.attributedPlaceholder = NSAttributedString(string: "Old Password", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        newPasswordTextField.textField.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        confirmPasswordTextField.textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: placeholderFont)])
        
        // Keyboard Control
        /* oldPasswordTextField.textField.becomeFirstResponder() */ // Commented until further decision
        
        // Tap Gesture Recognizer for dismissing keyboard on tap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangePasswordViewController.tap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Update Password Button
        updatePasswordButton.buttonOutlet.layer.cornerRadius = 5
        
        // Update Password Button Attributed Title
        guard let updatePasswordButtonFont = UIFont(name: "Nunito-SemiBold", size: 17) else {
            fatalError("""
                    Failed to load the "Nunito-SemiBold" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
        }
        
        let updatePasswordButtonAttributes = NSAttributedString(string: "Update Password", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: updatePasswordButtonFont)])
        
        updatePasswordButton.buttonOutlet.setAttributedTitle(updatePasswordButtonAttributes, for: .normal)
        updatePasswordButton.buttonOutlet.setAttributedTitle(updatePasswordButtonAttributes, for: .highlighted)
        updatePasswordButton.buttonOutlet.setAttributedTitle(updatePasswordButtonAttributes, for: .focused)
        updatePasswordButton.buttonOutlet.tintColor = UIColor.white
        
        if oldPasswordTextField.textField.text!.isEmpty && newPasswordTextField.textField.text!.isEmpty && confirmPasswordTextField.textField.text!.isEmpty {
            updatePasswordButton.buttonOutlet.isUserInteractionEnabled = false
            updatePasswordButton.buttonOutlet.backgroundColor = UIColor(named: "Disabled Button")!
        }
        
        updatePasswordButton.buttonOutlet.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        
    }
    
    
    // MARK: - Button Methods
    
    @objc func changePassword(button: UIButton) {
        self.postChangePassword(password: confirmPasswordTextField.textField.text ?? "")
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


// MARK: - UITextFieldDelegate

extension ChangePasswordViewController: UITextFieldDelegate {
    // Keyboard Control
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oldPasswordTextField.textField {
            newPasswordTextField.textField.becomeFirstResponder()
            newPasswordTextField.textField.addBottomBorder(color: UIColor(named: "Button Blue")!)
        }
        if textField == newPasswordTextField.textField {
            confirmPasswordTextField.textField.becomeFirstResponder()
            confirmPasswordTextField.textField.addBottomBorder(color: UIColor(named: "Button Blue")!)
        }
        if textField == confirmPasswordTextField.textField {
            confirmPasswordTextField.textField.resignFirstResponder()
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

        if oldPasswordTextField.textField.text!.isEmpty || newPasswordTextField.textField.text!.isEmpty || confirmPasswordTextField.textField.text!.isEmpty {
            updatePasswordButton.buttonOutlet.isUserInteractionEnabled = false
            updatePasswordButton.buttonOutlet.backgroundColor = UIColor(named: "Disabled Button")!
        } else {
            updatePasswordButton.buttonOutlet.isUserInteractionEnabled = true
            updatePasswordButton.buttonOutlet.backgroundColor = UIColor(named: "Button Blue")!
        }

        return true
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


// MARK: - Profile View Model Delegate

// Commented until further optimization

extension ChangePasswordViewController: changePasswordViewModelDelegate {
    func onSuccessRequest() {
        self.removeSpinner()
        let alertController = UIAlertController(title: "Success" , message: "Password Updated!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func onErrorRequest() {
        self.removeSpinner()
        let alertController = UIAlertController(title: "Error" , message: "Change Password Failed!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}



// MARK: - Methods

extension ChangePasswordViewController {
    func postChangePassword(password: String) {
//        self.showParentSpinner()
        viewModel.changePassword(password: password)
    }
}
