//
//  LoginViewController.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 07/12/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
  
    let userDefaults = UserDefaults()
    var iconClick = false
    let imageIcon = UIImageView()
    let button = UIButton(type: .custom)
    let textfieldColorBorder: UIColor = UIColor.rgb(red: 70, green: 163, blue: 249)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        btnLogin.layer.cornerRadius = 10
        btnShowPassword()
        setTextFieldBorder()
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
    func setTextFieldBorder() {
        let bottomLineEmail = CALayer()
        bottomLineEmail.frame = CGRect(x: 0, y: self.emailTxtField.frame.size.height - 1, width: self.emailTxtField.frame.size.width, height: 1)
        bottomLineEmail.backgroundColor = textfieldColorBorder.cgColor
        emailTxtField.borderStyle = .none
        emailTxtField.layer.addSublayer(bottomLineEmail)
        
        let bottomLinePassword = CALayer()
        bottomLinePassword.frame = CGRect(x: 0, y: self.passwordTxtField.frame.size.height - 1, width: self.passwordTxtField.frame.size.width, height: 1)
        bottomLinePassword.backgroundColor = textfieldColorBorder.cgColor
        passwordTxtField.borderStyle = .none
        passwordTxtField.layer.addSublayer(bottomLinePassword)
    }

    @IBAction func actionBtnSignUp(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: false)
    }
    @IBAction func actionBtnLogin(_ sender: Any) {
        self.activityIndicator.isHidden = false
        guard let email = emailTxtField.text, email != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Email is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            activityIndicator.isHidden = true
            return
        }
        guard let password = passwordTxtField.text, password != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Password is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            activityIndicator.isHidden = true
            return
        }
        
        loginApiAF(email: emailTxtField.text!, password: passwordTxtField.text!)
    }
    @IBAction func actionBtnForgot(_ sender: Any) {
    }

    func loginApiAF(email: String, password: String) {
        activityIndicator.isHidden = false
        btnLogin.isHidden = true
        Alamofire.request("https://medikuy.herokuapp.com/login", method: .post, parameters: ["email":"\(email)", "password":"\(password)"]).responseJSON { (responseJson) in
            
            do{
                let decoder = JSONDecoder()
                let dataUser = try decoder.decode(UserModel.self, from: responseJson.data!)
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.userDefaults.setValue(dataUser.user.email, forKey: "email")
                    self.userDefaults.setValue(dataUser.user.birthDate, forKey: "birthdate")
                    self.userDefaults.setValue(dataUser.token, forKey: "token")
                    self.userDefaults.setValue(dataUser.user.passwordDigest, forKey: "passwordDigest")
                    self.userDefaults.setValue(dataUser.user.gender, forKey: "gender")
                    self.userDefaults.setValue(dataUser.user.phoneNumber, forKey: "phoneNumber")
                    self.userDefaults.setValue(dataUser.user.fullName, forKey: "fullName")
                    self.btnLogin.isHidden = false

                    if let emailUser = self.userDefaults.value(forKey: "email") as? String {
                        print("Email: \(emailUser)")
                    }
                    if let birthdateUser = self.userDefaults.value(forKey: "birthdate") as? String {
                        print("Date: \(birthdateUser)")
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.btnLogin.isHidden = false
                    let alertController = UIAlertController(title: "Error" , message: "Register Failed", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    

}
