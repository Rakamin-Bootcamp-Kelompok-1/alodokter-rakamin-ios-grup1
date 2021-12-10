//
//  SignOutButton.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 08/12/21.
//

import UIKit

class SignOutButton: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var buttonOutlet: UIButton!
    
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
        Bundle.main.loadNibNamed("SignOutButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
