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
        // Tags are used to Auto Jump to next TextField; see func textFieldShouldReturn
        oldPasswordTextField.textField.tag = 1
        newPasswordTextField.textField.tag = 2
        confirmPasswordTextField.textField.tag = 3
        
        oldPasswordTextField.textField.delegate = self
        newPasswordTextField.textField.delegate = self
        confirmPasswordTextField.textField.delegate = self
        
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
    // Auto Jump upon 'tab' from TextField (tag) to TexField (tag+1)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Always dismiss KB upon textField 'Return'
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            nextTextField.becomeFirstResponder()
//            nextTextField.layer.cornerRadius = 5
//            nextTextField.layer.borderWidth = 1
//            nextTextField.layer.borderColor = UIColor.init(hex: "46A3F9", alpha: 1.0).cgColor
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.layer.cornerRadius = 5
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.init(hex: "46A3F9", alpha: 1.0).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.layer.borderWidth = 0
//        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
