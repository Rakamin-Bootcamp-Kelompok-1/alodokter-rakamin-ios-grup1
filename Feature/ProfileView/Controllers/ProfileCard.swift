//
//  ProfileCard.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 07/12/21.
//

import UIKit

class ProfileCard: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var profileCardRow1: ProfileCardRow!
    @IBOutlet weak var profileCardRow2: ProfileCardRow!
    
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
        Bundle.main.loadNibNamed("ProfileCard", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
