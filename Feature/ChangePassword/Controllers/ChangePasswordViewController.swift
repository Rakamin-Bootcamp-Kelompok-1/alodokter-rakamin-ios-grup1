//
//  ChangePasswordViewController.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 10/12/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var oldPasswordTextField: SecuredTextField!
    @IBOutlet weak var newPasswordTextField: SecuredTextField!
    @IBOutlet weak var confirmPasswordTextField: SecuredTextField!
    @IBOutlet weak var updatePasswordButton: LargeButton!
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    
    
    // MARK: - Prepare UI Method
    
    func prepareUI() {
        // Navigation Bar Title
        guard let navBarTitleFont = UIFont(name: "Nunito-SemiBold", size: 17) else {
            fatalError("""
                    Failed to load the "Nunito-SemiBold" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
        }
        
        let navBarTitleAttributes = [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: navBarTitleFont)]
        
        self.navigationController?.navigationBar.titleTextAttributes = navBarTitleAttributes
        self.title = "Change Password"
        
        oldPasswordTextField.textField.delegate = self
        newPasswordTextField.textField.delegate = self
        confirmPasswordTextField.textField.delegate = self
        
        oldPasswordTextField.textField.addBottomBorder(color: UIColor(hex: "BCBCBC", alpha: 1.0))
        newPasswordTextField.textField.addBottomBorder(color: UIColor(hex: "BCBCBC", alpha: 1.0))
        confirmPasswordTextField.textField.addBottomBorder(color: UIColor(hex: "BCBCBC", alpha: 1.0))
        
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
        
        oldPasswordTextField.textField.becomeFirstResponder()
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(ChangePasswordViewController.tap(_:)))
        view.addGestureRecognizer(tapGestureReconizer)
        
        
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
        updatePasswordButton.buttonOutlet.tintColor = UIColor.white
        
        if oldPasswordTextField.textField.text!.isEmpty && newPasswordTextField.textField.text!.isEmpty && confirmPasswordTextField.textField.text!.isEmpty {
            updatePasswordButton.buttonOutlet.isUserInteractionEnabled = false
            updatePasswordButton.buttonOutlet.backgroundColor = UIColor(hex: "C4C4C4", alpha: 1.0)
        }
        
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
            newPasswordTextField.textField.addBottomBorder(color: UIColor.init(hex: "46A3F9", alpha: 1.0))
        }
        if textField == newPasswordTextField.textField {
            confirmPasswordTextField.textField.becomeFirstResponder()
            confirmPasswordTextField.textField.addBottomBorder(color: UIColor.init(hex: "46A3F9", alpha: 1.0))
        }
        if textField == confirmPasswordTextField.textField {
            confirmPasswordTextField.textField.resignFirstResponder()
        }
    
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addBottomBorder(color: UIColor.init(hex: "46A3F9", alpha: 1.0))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.addBottomBorder(color: UIColor(hex: "BCBCBC", alpha: 1.0))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if oldPasswordTextField.textField.text!.isEmpty || newPasswordTextField.textField.text!.isEmpty || confirmPasswordTextField.textField.text!.isEmpty {
            updatePasswordButton.buttonOutlet.isUserInteractionEnabled = false
            updatePasswordButton.buttonOutlet.backgroundColor = UIColor(hex: "C4C4C4", alpha: 1.0)
        } else {
            updatePasswordButton.buttonOutlet.isUserInteractionEnabled = true
            updatePasswordButton.buttonOutlet.backgroundColor = UIColor(hex: "46A3F9", alpha: 1.0)
        }

        return true
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
