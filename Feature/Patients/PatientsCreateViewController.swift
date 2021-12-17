//
//  CreatePatientsViewController.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 17/12/21.
//

import UIKit
class PatientsCreateViewController: BaseViewController {
    
    @IBOutlet weak var pcNameTxtField: UITextField!
    @IBOutlet weak var pcMaleRadio: UIImageView!
    @IBOutlet weak var pcFemaleRadio: UIImageView!
    @IBOutlet weak var pcBirthTxtField: UITextField!
    @IBOutlet weak var pcBloodTxtField: UITextField!
    @IBOutlet weak var pcStatusTextField: UITextField!
    @IBOutlet weak var pcCreateButton: UIButton!
    
    private var pcStatusPicker = UIPickerView()
    private var pcBloodPicker = UIPickerView()
    private var pcStatusArr = ["Anak", "Istri", "Orang Tua", "Kerabat"]
    private var pcBloodArr = ["A","B","AB","O"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tambah Pasien"
        setViews()
    }
    
    func setViews(){
        //Buttons
        let gest1 = UITapGestureRecognizer(target: self, action: #selector(didTapMaleRadio(_:)))
        let gest2 = UITapGestureRecognizer(target: self, action: #selector(didTapFemaleRadio(_:)))
        pcMaleRadio.isUserInteractionEnabled = true
        pcFemaleRadio.isUserInteractionEnabled = true
        pcMaleRadio.addGestureRecognizer(gest1)
        pcFemaleRadio.addGestureRecognizer(gest2)
        pcCreateButton.alpha = 0.5
        pcCreateButton.isUserInteractionEnabled = false
        pcCreateButton.addTarget(self, action: #selector(didTapCreate(_:)), for: .touchUpInside)
        
        //TextFields
        pcNameTxtField.delegate = self
        pcNameTxtField.addBottomBorder(color: .gray)
        pcBirthTxtField.addBottomBorder(color: .gray)
        pcBloodTxtField.addBottomBorder(color: .gray)
        pcStatusTextField.addBottomBorder(color: .gray)
        
        //Pickers
        pcStatusPicker.dataSource = self
        pcStatusPicker.delegate = self
        pcStatusPicker.tag = 1
        pcStatusTextField.inputView = pcStatusPicker
        pcBloodPicker.dataSource = self
        pcBloodPicker.delegate = self
        pcBloodPicker.tag = 2
        pcBloodTxtField.inputView = pcBloodPicker
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(didTapBirthButton), for: UIControl.Event.valueChanged)
        pcBirthTxtField.inputView = datePicker
        
    }

}

//MARK: - objc function
extension PatientsCreateViewController{
    
    @objc func didTapMaleRadio(_ sender: UITapGestureRecognizer){
        pcMaleRadio.image = UIImage(named: "ic_radio_selected")
        pcFemaleRadio.image = UIImage(named: "ic_radio_unselected")
    }
    
    @objc func didTapFemaleRadio(_ sender: UITapGestureRecognizer){
        pcMaleRadio.image = UIImage(named: "ic_radio_unselected")
        pcFemaleRadio.image = UIImage(named: "ic_radio_selected")
    }
    
    @objc func didTapBirthButton(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        pcBirthTxtField.text = formatter.string(from: sender.date)
    }
    
    @objc func didTapCreate(_ sender: UIButton){
        
    }
}

extension PatientsCreateViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty && pcBloodTxtField.text == ""{
            pcCreateButton.alpha = 0.5
            pcCreateButton.isUserInteractionEnabled = false
        }else{
            pcCreateButton.alpha = 1
            pcCreateButton.isUserInteractionEnabled = true
        }
        return true
    }
 
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        pickerView.tag == 1 ? pcStatusArr.count : pcBloodArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.tag == 1 ? pcStatusArr[row] : pcBloodArr[row]
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 1{
            pcStatusTextField.text = pcStatusArr[row]
        }else{
            pcBloodTxtField.text = pcBloodArr[row]
        }
        
    }
}
