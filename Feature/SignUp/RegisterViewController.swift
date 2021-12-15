//
//  RegisterViewController.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 04/12/21.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmationTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    let button = UIButton(type: .custom)
    let buttonConfirmation = UIButton(type: .custom)
    let genders = ["Female", "Male"]
    var pickerView = UIPickerView()
    let textfieldColorBorder: UIColor = UIColor.rgb(red: 70, green: 163, blue: 249)
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 10
        btnShowPassword()
        setDateTextField()
        setGenderTextField()
        setTextfieldBorder()
        let dateImage = UIImage(named: "calender")
        addImageTextfield(txtField: dateTxtField, img: dateImage!)
        btnSignIn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
    }
    
    @objc private func hideKeyboard(){
        
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
            print("Register")
            self.registerAF(email: emailTxtField.text!, password: passwordTxtField.text!, name: nameTxtField.text!, birthdate: dateTxtField.text!, phone: phoneTxtField.text!, gender: genderTxtField.text!)
        }
    }
    
    func registerAF(email: String, password: String, name: String, birthdate:String, phone:String, gender:String){
        self.activityView.isHidden = false
        Alamofire.request("https://medikuy.herokuapp.com/user/add", method: .post, parameters: ["full_name": "\(name)", "password": "\(password)", "email": "\(email)", "gender": "\(gender)", "birth_date": "\(birthdate)", "phone_number": "\(phone)"]).validate().responseJSON { response in
            switch response.result {
            case .success:
                let alertController = UIAlertController(title: "Success" , message: "Account has been registered", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
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
            case .failure(let error):
                print(error)
                self.activityView.isHidden = true
                let alertController = UIAlertController(title: "Error" , message: "Invalid Username or Password", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
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
        self.navigationController?.pushViewController(loginVC, animated: false)
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
