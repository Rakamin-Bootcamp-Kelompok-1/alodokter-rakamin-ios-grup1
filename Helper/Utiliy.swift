//
//  Utiliy.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation
import UIKit
import SwiftyJSON

class Utility {
    public func isValidEmail(text: String?) -> Bool {
        if text != nil {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: text)
        }
        
        return false
    }
    
    public func checkTextFieldIsEmpty(textfield:UITextField) -> Bool {
        if textfield.text == "" {
            return true
        }
        return false
    }
    
    public func checkTextviewIsEmpty(textview:UITextView) -> Bool {
        let enteredText = textview.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if enteredText == "" {
            return true
        }
        return false
    }
    
    public func getBaseHeader() -> [String:String]{
        var header: [String:String] = [:]
        header["Content-Type"] = "application/json"
        header["Accept-Language"] = "en"
        return header
    }
    
    public func getStringFromInt(data:Int?) -> String{
        var fixedString = ""
        if let fixed = data {
            fixedString = String(fixed)
        } else {
            fixedString = ""
        }
        return fixedString
    }
}
