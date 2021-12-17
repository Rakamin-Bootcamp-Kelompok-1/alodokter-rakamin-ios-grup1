//
//  SchedulesCollectionViewCell.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import UIKit

class SchedulesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var scheduleLbl: UILabel!
    static let identifier = "SchedulesCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(schedule: ScheduleDoctorResource) {
        self.scheduleLbl.text = (schedule.day ?? "") + "" + (schedule.date ?? "") + "" + (schedule.month ?? "") + "" + (schedule.year ?? "")
        self.timeLbl.text = schedule.timePractice ?? "no time available"
    }

}
