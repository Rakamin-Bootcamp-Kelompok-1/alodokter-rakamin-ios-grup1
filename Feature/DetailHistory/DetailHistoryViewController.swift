//
//  DetailHistoryViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 09/12/21.
//

import UIKit
import SDWebImage
class DetailHistoryViewController: BaseViewController {

    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var informationBookView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var messagePatient: UILabel!
    @IBOutlet weak var patientLbl: UILabel!
    @IBOutlet weak var patientGender: UILabel!
    @IBOutlet weak var patientBirthLbl: UILabel!
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var bloodLbl: UILabel!
    @IBOutlet weak var bookingDateLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var paymentLbl: UILabel!
    static let identifier = "DetailHistoryViewController"
    var dataHistory: HistoryBookingResource!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "History"
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.navigationBar.tintColor = UIColor.black
        doctorImg.layer.cornerRadius = 5
        messageView.layer.cornerRadius = 8
        messageView.layer.masksToBounds = true
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageView.layer.borderWidth = 0.5
        informationBookView.layer.borderColor = UIColor.lightGray.cgColor
        informationBookView.layer.borderWidth = 0.5
        informationBookView.layer.cornerRadius = 8
        totalPriceView.layer.borderColor = UIColor.lightGray.cgColor
        totalPriceView.layer.borderWidth = 0.5
        totalPriceView.layer.cornerRadius = 8
        paymentView.layer.borderColor = UIColor.lightGray.cgColor
        paymentView.layer.borderWidth = 0.5
        paymentView.layer.cornerRadius = 8
        
        self.messagePatient.text = dataHistory.message ?? ""
        self.doctorName.text = dataHistory.doctor?.doctorName ?? ""
        self.specialityLbl.text = dataHistory.doctor?.speciality ?? ""
        self.doctorImg.sd_setImage(with: URL(string: dataHistory.doctor?.imagePath ?? ""),placeholderImage:UIImage(named: "ic_dokter_umum"))
        self.totalPriceLbl.text = String(dataHistory.totalPrice ?? 0) ?? "0"
        self.paymentLbl.text = dataHistory.paymentMethod ?? ""
        if dataHistory.patient != nil {
            
            self.patientLbl.text = dataHistory.patient?.patientName ?? ""
            self.patientGender.text = dataHistory.patient?.gender ?? ""
            self.patientBirthLbl.text = dataHistory.patient?.birthDate ?? ""
            self.patientAge.text = String(dataHistory.patient?.age ?? 0) ?? ""
            self.bookingDateLbl.text = (dataHistory.doctorSchedule?.date ?? "0") + " " + (dataHistory.doctorSchedule?.month ?? "") + " " + (dataHistory.doctorSchedule?.year ?? "")
        }
        
        
        // Do any additional setup after loading the view.
    }


    

}
