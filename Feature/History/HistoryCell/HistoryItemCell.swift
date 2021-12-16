//
//  HistoryItemCell.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 09/12/21.
//

import UIKit
import SDWebImage
class HistoryItemCell: UICollectionViewCell {

    static let identifier = "HistoryItemCell"
    
    @IBOutlet weak var backViewCell: UIView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var specialtyLbl: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var doctorImg: UIImageView!
    
    func setup(history: HistoryBookingResource) {
        self.doctorName.text = history.doctor?.doctorName
        self.specialtyLbl.text = history.doctor?.speciality
        self.doctorImg.sd_setImage(with: URL(string: history.doctor?.imagePath ?? ""))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        doctorImg.layer.cornerRadius = 5
        backgroundColor = UIColor.clear
//
//            self.backViewCell.layer.borderWidth = 1
            self.backViewCell.layer.cornerRadius = 10
//        self.backViewCell.layer.borderColor = UIColor.clear.cgColor
//            self.backViewCell.layer.masksToBounds = true
////
//            self.layer.shadowOpacity = 0.18
//            self.layer.shadowOffset = CGSize(width: 0, height: 2)
//            self.layer.shadowRadius = 2
//        self.layer.shadowColor = UIColor.black.cgColor
//            self.layer.masksToBounds = false
        
    }
    
    
    
    


    
    
    
    
    
}
