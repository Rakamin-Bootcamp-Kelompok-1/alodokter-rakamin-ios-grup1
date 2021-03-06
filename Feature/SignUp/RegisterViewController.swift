//
//  RegisterViewController.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 04/12/21.
//

import UIKit
import Alamofire

class RegisterViewController: BaseViewController {
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmationTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    
    let userDefaults = UserDefaults()
    let button = UIButton(type: .custom)
    let buttonConfirmation = UIButton(type: .custom)
    let genders = ["Female", "Male"]
    var pickerView = UIPickerView()
    let textfieldColorBorder: UIColor = UIColor.rgb(red: 70, green: 163, blue: 249)
    var activeTextField: UITextField!
    var viewModel = RegisterViewModel()
    var status: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 10
        viewModel.delegate = self
        btnShowPassword()
        setDateTextField()
        setGenderTextField()
        setTextfieldBorder()
        let dateImage = UIImage(named: "calender")
        addImageTextfield(txtField: dateTxtField, img: dateImage!)
        btnSignIn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
    }

    func addImageTextfield(txtField: UITextField, img: UIImage){
        let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))
        rightImageView.image = img
        txtField.rightView = rightImageView
        txtField.rightViewMode = .always
    }

    func setTextfieldBorder() {
        let bottomLineGender = CALayer()
        bottomLineGender.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLineGender.backgroundColor = textfieldColorBorder.cgColor
        genderTxtField.borderStyle = .none
        genderTxtField.layer.addSublayer(bottomLineGender)
        
        let bottomLineConfirmation = CALayer()
        bottomLineConfirmation.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLineConfirmation.backgroundColor = textfieldColorBorder.cgColor
        confirmationTxtField.borderStyle = .none
        confirmationTxtField.layer.addSublayer(bottomLineConfirmation)
        
        let bottomLinePassword = CALayer()
        bottomLinePassword.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLinePassword.backgroundColor = textfieldColorBorder.cgColor
        passwordTxtField.borderStyle = .none
        passwordTxtField.layer.addSublayer(bottomLinePassword)
        
        let bottomLinePhone = CALayer()
        bottomLinePhone.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLinePhone.backgroundColor = textfieldColorBorder.cgColor
        phoneTxtField.borderStyle = .none
        phoneTxtField.layer.addSublayer(bottomLinePhone)
        
        let bottomLineDate = CALayer()
        bottomLineDate.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLineDate.backgroundColor = textfieldColorBorder.cgColor
        dateTxtField.borderStyle = .none
        dateTxtField.layer.addSublayer(bottomLineDate)
        
        let bottomLineEmail = CALayer()
        bottomLineEmail.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLineEmail.backgroundColor = textfieldColorBorder.cgColor
        emailTxtField.borderStyle = .none
        emailTxtField.layer.addSublayer(bottomLineEmail)
        
        let bottomLineName = CALayer()
        bottomLineName.frame = CGRect(x: 0, y: self.nameTxtField.frame.size.height - 1, width: self.nameTxtField.frame.size.width, height: 1)
        bottomLineName.backgroundColor = textfieldColorBorder.cgColor
        nameTxtField.borderStyle = .none
        nameTxtField.layer.addSublayer(bottomLineName)
    }
  
    
    func setGenderTextField() {
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTxtField.inputView = pickerView
    }
    
    func setDateTextField() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChange), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        dateTxtField.inputView = datePicker
        
        
    }
    @objc func datePickerValueChange(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTxtField.text = formatter.string(from: sender.date)
    }
    
    @IBAction func actionBtnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBtnSignUp(_ sender: Any) {
        guard let name = nameTxtField.text, name != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Full Name is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let email = emailTxtField.text, email != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Email is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let date = dateTxtField.text, date != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Date is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let phone = phoneTxtField.text, phone != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Phone Number is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let gender = genderTxtField.text, gender != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Gender is Require", preferredStyle: .alert)
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
        guard let confirmation = confirmationTxtField.text, confirmation != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Confirmation Password is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if nameTxtField.text!.count < 8 {
            let alertController = UIAlertController(title: "Error" , message: "Minimum of 8 characters for Full Name", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else if emailTxtField.text!.count < 8 {
            let alertController = UIAlertController(title: "Error" , message: "Minimum of 8 characters for Email", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else if phoneTxtField.text!.count < 11 {
            let alertController = UIAlertController(title: "Error" , message: "Minimum of 11 digit for Phone Number", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else if passwordTxtField.text! != confirmationTxtField.text! {
            let alertController = UIAlertController(title: "Error" , message: "The password does not match", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            viewModel.registerAPI(name: nameTxtField.text!, password: passwordTxtField.text!, email: emailTxtField.text!, gender: genderTxtField.text!, birtdate: dateTxtField.text!, phone: phoneTxtField.text!)
            self.activityView.isHidden = false
        }
    }

    func btnShowPassword() {
        button.setImage(UIImage(named: "offEye"), for: .normal)
        button.setImage(UIImage(named: "onEye"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        passwordTxtField.rightView = button
        passwordTxtField.rightViewMode = .always
        passwordTxtField.autocorrectionType = .no
        passwordTxtField.textContentType = .newPassword
        button.alpha = 0.4
        
        buttonConfirmation.setImage(UIImage(named: "offEye"), for: .normal)
        buttonConfirmation.setImage(UIImage(named: "onEye"), for: .selected)
        buttonConfirmation.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        buttonConfirmation.addTarget(self, action: #selector(togglePasswordViewConfirmation), for: .touchUpInside)
        confirmationTxtField.rightView = buttonConfirmation
        confirmationTxtField.rightViewMode = .always
        confirmationTxtField.autocorrectionType = .no
        confirmationTxtField.textContentType = .newPassword
        buttonConfirmation.alpha = 0.4
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        passwordTxtField.isSecureTextEntry.toggle()
        button.isSelected.toggle()
        }
    
    @objc func togglePasswordViewConfirmation(_ sender: Any) {
        confirmationTxtField.isSecureTextEntry.toggle()
        buttonConfirmation.isSelected.toggle()
        }
}

extension RegisterViewController: RegisterViewModelProtocol {
    func onRegistered() {
        self.activityView.isHidden = true
        let alertController = UIAlertController(title: "Error" , message: "Email has been registered", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onSuccess() {
        self.activityView.isHidden = true
        let alertController = UIAlertController(title: "Success" , message: "Account has been registered", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { action in
            let tabBarViewController = TabBarViewController()
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(tabBarViewController, animated: false)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        self.activityView.isHidden = true
        self.nameTxtField.text = ""
        self.emailTxtField.text = ""
        self.dateTxtField.text = ""
        self.phoneTxtField.text = ""
        self.genderTxtField.text = ""
        self.passwordTxtField.text = ""
        self.confirmationTxtField.text = ""
    }
    func onFailure() {
        self.activityView.isHidden = true
        let alertController = UIAlertController(title: "Error" , message: "Register Failed", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTxtField.text = genders[row]
        genderTxtField.resignFirstResponder()
    }
    
}
