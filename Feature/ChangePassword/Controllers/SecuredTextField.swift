//
//  SecureTextField.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 10/12/21.
//

import UIKit

class SecuredTextField: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: TextFieldWithPadding!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var eyeButtonOutlet: UIButton!
    
    // For using CustomView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // For using CustomView in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // Do stuffs here
    private func commonInit() {
        Bundle.main.loadNibNamed("SecuredTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        textField.isSecureTextEntry = true
        
        if #available(iOS 13.0, *) {
            eyeButtonOutlet.setTitle("", for: .normal)
            eyeButtonOutlet.setImage(UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(scale: .default)), for: .normal)
            eyeButtonOutlet.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    @objc
    func toggleShowHide(button: UIButton) {
        toggle()
    }
    
    func toggle() {
        if #available(iOS 13.0, *) {
            textField.isSecureTextEntry = !textField.isSecureTextEntry
            if let existingText = textField.text, textField.isSecureTextEntry {
                eyeButtonOutlet.setImage(UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(scale: .default)), for: .normal)
                
                textField.deleteBackward()
                
                if let textRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) {
                    textField.replace(textRange, withText: existingText)
                }
                
                if let existingSelectedTextRange = textField.selectedTextRange {
                    textField.selectedTextRange = nil
                    textField.selectedTextRange = existingSelectedTextRange
                }
            } else {
                eyeButtonOutlet.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(scale: .default)), for: .normal)
            }
        } else {
            // Fallback on earlier versions
        }
    }

}
