//
//  PasswordForgotViewController.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 15/12/21.
//

import UIKit

class PasswordForgotViewController: UIViewController {

    @IBOutlet weak var pfEmailTextField: UITextField!
    @IBOutlet weak var pfErrorLabel: UILabel!
    @IBOutlet weak var pfSubmitButton: UIButton!
    @IBOutlet weak var pfSignUpButton: UIButton!
    
    private let buttonSubmitAttr:(String) -> NSAttributedString = { text in
        NSAttributedString(string: text, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
    }
    
    private let viewModel = PasswordForgotViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setInitialData()
    }
    
    func setInitialData(){
        viewModel.delegate = self
        pfSubmitButton.addTarget(self, action: #selector(didTapSubmit(_:)), for: .touchUpInside)
        pfSignUpButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
    }
    
    func setView(){
        pfErrorLabel.isHidden = true
        pfEmailTextField.layer.borderColor = UIColor.rgb(red: 170, green: 217, blue: 233).cgColor
        pfEmailTextField.layer.masksToBounds = true
        pfEmailTextField.layer.borderWidth = 2
        pfEmailTextField.layer.cornerRadius = 10
    }
    
    @objc func didTapSubmit(_ sender: UIButton){
        pfErrorLabel.isHidden = false
        pfSubmitButton.isUserInteractionEnabled = false
        pfSubmitButton.backgroundColor = UIColor.gray
        pfSubmitButton.setAttributedTitle(buttonSubmitAttr("Resend Email"), for: .normal)
        viewModel.beginVerification()
        
    }
    
    @objc func didTapSignUp(_ sender: UIButton){
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }

}

extension PasswordForgotViewController: PasswordForgotProtocol{
    
    func updateView() {
        pfSubmitButton.isUserInteractionEnabled = true
        pfSubmitButton.backgroundColor = UIColor.rgb(red: 114, green: 185, blue: 251)
    }
    
}
