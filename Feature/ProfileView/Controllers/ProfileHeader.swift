//
//  ProfileCard.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 07/12/21.
//

import UIKit

class ProfileHeader: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profilePhoneNumberLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("ProfileHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
