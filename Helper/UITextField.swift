//
 //  TextField.swift
 //  Alodokter_bootcamp
 //
 //  Created by Rayhan Faluda on 11/12/21.
 //

 import Foundation
 import UIKit

 // MARK: - UITextField Subclass

 class TextFieldWithPadding: UITextField {
     var textPadding = UIEdgeInsets(
         top: 0,
         left: 0,
         bottom: 0,
         right: 40
     )

     override func textRect(forBounds bounds: CGRect) -> CGRect {
         let rect = super.textRect(forBounds: bounds)
         return rect.inset(by: textPadding)
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         let rect = super.editingRect(forBounds: bounds)
         return rect.inset(by: textPadding)
     }
 }


 // MARK: - UITextField Bottom Border

 extension UITextField {
     func addBottomBorder(color: UIColor) {
         let border = CALayer()
         let width = CGFloat(1.0)
         border.borderColor = color.cgColor
         border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
         border.borderWidth = width
         self.layer.addSublayer(border)
         self.layer.masksToBounds = true
     }
     
     func setInputViewDatePicker(target: Any, selector: Selector) {
         // Create a UIDatePicker object and assign to inputView
         let screenWidth = UIScreen.main.bounds.width
         let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
         datePicker.datePickerMode = .date //2
         // iOS 14 and above
         if #available(iOS 14, *) {// Added condition for iOS 14
             datePicker.preferredDatePickerStyle = .wheels
             datePicker.sizeToFit()
         }
         self.inputView = datePicker //3
         
         // Create a toolbar and assign it to inputAccessoryView
         let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
         let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
         let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
         let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
         toolBar.setItems([cancel, flexible, barButton], animated: false) //8
         self.inputAccessoryView = toolBar //9
     }
     
     @objc func tapCancel() {
         self.resignFirstResponder()
     }
 }

