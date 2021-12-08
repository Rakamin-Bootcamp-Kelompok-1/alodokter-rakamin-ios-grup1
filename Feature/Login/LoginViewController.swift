//
//  LoginViewController.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 07/12/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    var iconClick = false
    let imageIcon = UIImageView()
    let button = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogin.layer.cornerRadius = 10
        btnShowPassword()

    }
    @objc func togglePasswordView(_ sender: Any) {
        passwordTxtField.isSecureTextEntry.toggle()
        button.isSelected.toggle()
        }
    func btnShowPassword() {
        button.setImage(UIImage(named: "offEye"), for: .normal)
        button.setImage(UIImage(named: "onEye"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        passwordTxtField.rightView = button
        passwordTxtField.rightViewMode = .always
        button.alpha = 0.4
    }

    @IBAction func actionBtnSignUp(_ sender: Any) {
    }
    @IBAction func actionBtnLogin(_ sender: Any) {
        guard let email = emailTxtField.text, email != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Email is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let password = passwordTxtField.text, password != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Password is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        print("login")

    }
    @IBAction func actionBtnForgot(_ sender: Any) {
    }
    

}
