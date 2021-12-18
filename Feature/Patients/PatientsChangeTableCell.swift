//
//  PatientsChangeTableCell.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 17/12/21.
//

import UIKit

class PatientsChangeTableCell: UITableViewCell {
    
    @IBOutlet weak var pcNameLabel: UILabel!
    @IBOutlet weak var pcSexLabel: UILabel!
    @IBOutlet weak var pcBirthLabel: UILabel!
    @IBOutlet weak var pcAgeLabel: UILabel!
    @IBOutlet weak var pcBloodLabel: UILabel!
    @IBOutlet weak var pcStatusLabel: UILabel!
    @IBOutlet weak var pcRadioImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if #available(iOS 13.0, *) {
            pcRadioImage.image = selected ?  UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle.fill")
            pcRadioImage.tintColor = selected ? UIColor(named: "AccentColor") : UIColor.systemGray4
        }
        
    }
    
}
