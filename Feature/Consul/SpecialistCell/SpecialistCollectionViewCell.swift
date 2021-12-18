//
//  SpecialistCollectionViewCell.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

class SpecialistCollectionViewCell: UICollectionViewCell {

    static let identifier = "SpecialistCollectionViewCell"
    
    @IBOutlet weak var specialistImg: UIImageView!
    @IBOutlet weak var specialistLbl: UILabel!
    
    func setup(speciality: SpecialityModel) {
        specialistLbl.text = speciality.speciality
        specialistImg.image = speciality.image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
