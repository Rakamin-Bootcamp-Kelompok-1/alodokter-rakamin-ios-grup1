//
//  DoctorCollectionViewCell.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit
import SDWebImage
class DoctorCollectionViewCell: UICollectionViewCell {

    static let identifier = "DoctorCollectionViewCell"
    
    @IBOutlet weak var localtionLbl: UILabel!
    @IBOutlet weak var doctorLbl: UILabel!
    @IBOutlet weak var ViewConten: UIView!
    @IBOutlet weak var backViewCell: UIView!
    @IBOutlet weak var specialistLbl: UILabel!
    @IBOutlet weak var doctorImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.doctorImg.layer.cornerRadius = 5
       
        self.ViewConten.backgroundColor = .clear
        self.backViewCell.layer.cornerRadius = 10
//        self.backViewCell.backgroundColor = .brown
    }
    
    func setup(doctor: DoctorResource) {
        self.doctorLbl.text = doctor.doctorName
        self.specialistLbl.text = doctor.speciality
        self.localtionLbl.text = doctor.locationPractice
        self.doctorImg.sd_setImage(with: URL(string: doctor.imagePath ?? ""),placeholderImage:UIImage(named: "ic_dokter_umum"))
    }

}
