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
    @IBOutlet var btnClose: UIButton!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    var viewModel = LoginViewModel()
    let userDefaults = UserDefaults()
    var iconClick = false
    let imageIcon = UIImageView()
    let button = UIButton(type: .custom)
    let textfieldColorBorder: UIColor = UIColor.rgb(red: 70, green: 163, blue: 249)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        activityIndicator.isHidden = true
        btnLogin.layer.cornerRadius = 10
        btnShowPassword()
        setTextFieldBorder()
        
        self.navigationController?.navigationBar.isHidden = true
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

    @IBAction func actionBtnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBtnSignUp(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
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
        viewModel.loginAPI(email: emailTxtField.text!, password: passwordTxtField.text!)

    }
    @IBAction func actionBtnForgot(_ sender: Any) {
    }
}

extension LoginViewController: LoginViewModelProtocol{
    func onSuccess() {
        self.emailTxtField.text = ""
        self.passwordTxtField.text = ""
        self.activityIndicator.isHidden = true
        self.btnLogin.isHidden = false
        print("Login Success: \(self.viewModel.emailU)")
        
        let tabBarViewController = TabBarViewController()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(tabBarViewController, animated: false)
    }
    func onFailure() {
        self.activityIndicator.isHidden = true
        self.btnLogin.isHidden = false
        let alertController = UIAlertController(title: "Login Failed" , message: "Email/Password is wrong", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
