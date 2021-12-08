//
//  RegisterViewController.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 04/12/21.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var genderPickerView: UIPickerView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 10
        btnShowPassword()
        setDateTextField()
        setGenderTextField()
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
        guard let email = emailTxtField.text, email != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Email is Require", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let name = nameTxtField.text, name != "" else {
            let alertController = UIAlertController(title: "Error" , message: "Full Name is Require", preferredStyle: .alert)
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
