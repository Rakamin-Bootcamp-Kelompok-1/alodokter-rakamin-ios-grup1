//
//  RegisterViewController.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 04/12/21.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var confirmationTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    let button = UIButton(type: .custom)
    let buttonConfirmation = UIButton(type: .custom)
    let genders = ["Female", "Male"]
    var pickerView = UIPickerView()
    let colorBorder = UIColor(red: 170, green: 217, blue: 233, alpha: 1)
    let textfieldColorBorder: UIColor = UIColor.rgb(red: 170, green: 217, blue: 233)
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
        genderTxtField.layer.borderColor = textfieldColorBorder.cgColor
        genderTxtField.layer.masksToBounds = true
        genderTxtField.layer.borderWidth = 2
        genderTxtField.layer.cornerRadius = 10
        
        
        confirmationTxtField.layer.borderColor = textfieldColorBorder.cgColor
        confirmationTxtField.layer.masksToBounds = true
        confirmationTxtField.layer.borderWidth = 2
        confirmationTxtField.layer.cornerRadius = 10
        
        passwordTxtField.layer.borderColor = textfieldColorBorder.cgColor
        passwordTxtField.layer.masksToBounds = true
        passwordTxtField.layer.borderWidth = 2
        passwordTxtField.layer.cornerRadius = 10
        
        phoneTxtField.layer.borderColor = textfieldColorBorder.cgColor
        phoneTxtField.layer.masksToBounds = true
        phoneTxtField.layer.borderWidth = 2
        phoneTxtField.layer.cornerRadius = 10
        
        dateTxtField.layer.borderColor = textfieldColorBorder.cgColor
        dateTxtField.layer.masksToBounds = true
        dateTxtField.layer.borderWidth = 2
        dateTxtField.layer.cornerRadius = 10
        
        
        emailTxtField.layer.borderColor = textfieldColorBorder.cgColor
        emailTxtField.layer.masksToBounds = true
        emailTxtField.layer.borderWidth = 2
        emailTxtField.layer.cornerRadius = 10
        
        nameTxtField.layer.borderColor = textfieldColorBorder.cgColor
        nameTxtField.layer.masksToBounds = true
        nameTxtField.layer.borderWidth = 2
        nameTxtField.layer.cornerRadius = 10

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
        if passwordTxtField.text! != confirmationTxtField.text! {
            let alertController = UIAlertController(title: "Error" , message: "Password are not the same", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            print("Register")
        }
    }
    func btnShowPassword() {
        passwordTxtField.isSecureTextEntry = true
        confirmationTxtField.isSecureTextEntry = true
        button.setImage(UIImage(named: "offEye"), for: .normal)
        button.setImage(UIImage(named: "onEye"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        passwordTxtField.rightView = button
        passwordTxtField.rightViewMode = .always
        button.alpha = 0.4
        
        buttonConfirmation.setImage(UIImage(named: "offEye"), for: .normal)
        buttonConfirmation.setImage(UIImage(named: "onEye"), for: .selected)
        buttonConfirmation.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        buttonConfirmation.addTarget(self, action: #selector(togglePasswordViewConfirmation), for: .touchUpInside)
        confirmationTxtField.rightView = buttonConfirmation
        confirmationTxtField.rightViewMode = .always
        buttonConfirmation.alpha = 0.4
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
