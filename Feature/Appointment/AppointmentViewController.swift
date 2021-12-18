//
//  AppointmentViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/16/21.
//

import UIKit

class AppointmentViewController: BaseViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var pesanTextView: UITextView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorSubLabel: UILabel!
    @IBOutlet weak var doctorPriceLabel: UILabel!
    @IBOutlet weak var doctorStarLabel: UILabel!
    
    var oneWeekDateData: [(String, String)] = []
    var isFirstTime = true
    var doctorResource: DoctorResource?
    let viewModel = BookingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeData()
        viewSetup()
        initTimeCollectionView()
    }
    
    func viewSetup() {
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.borderColor = UIColor.gray.cgColor
        textFieldView.layer.cornerRadius = 15
        pesanTextView.text = "Masukan Pesan"
        paymentView.layer.borderWidth = 1
        paymentView.layer.borderColor = UIColor.gray.cgColor
        paymentView.layer.cornerRadius = 15
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToPaymentSelection(_:)) )
        tapGesture.delegate = self
        paymentView.addGestureRecognizer(tapGesture)
        doctorImageView.sd_setImage(with: URL(string: (doctorResource?.imagePath) ?? ""), placeholderImage: UIImage(named: "docter_image"))
        doctorSubLabel.text = doctorResource?.locationPractice
        doctorPriceLabel.text = "\(doctorResource?.priceRate ?? 0)"
        doctorStarLabel.text = "\(doctorResource?.star ?? "0") out of 5"
        viewModel.delegate = self
    }
    
    private func initTimeCollectionView() {
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.register(UINib(nibName: "AppointmentTimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
    }
    
    @IBAction func bookAnAppointment(_ sender: Any) {
        self.showParentSpinner()
        viewModel.book(body: [
            "message": pesanTextView.text ?? "",
            "payment_method": paymentLabel.text ?? "",
            "total_price": doctorResource?.priceRate ?? 0,
            "doctor_id": 1,
            "patient_id": 1,
            "doctor_schedule_id": 1,
            "user_id" : 1
        ])
    }
    
    func timeData() {
        for i in 0...6 {
            let date = Date()
            let calendar = Calendar.current.date(byAdding: .day, value: i, to: date)!
            let dateString = DateFormatter()
            dateString.dateFormat = "dd"
            let dayString = DateFormatter()
            dayString.locale = Locale(identifier: "id-ID")
            dayString.dateFormat = "E"
            let dayData = (dateString.string(from: calendar), dayString.string(from: calendar))
            oneWeekDateData.append(dayData)
        }
    }
    
    @objc func goToPaymentSelection(_ sender: UIView) {
        let paymentSelectionViewController = PaymentSelectionViewController()
        paymentSelectionViewController.appointmentVC = self
        present(paymentSelectionViewController, animated: true)
    }
    
    @IBAction func changePatientButton(_ sender: Any) {
        navigationController?.pushViewController(PatientsChangeViewController(), animated: true)
    }
}

extension AppointmentViewController: BookingProtocol {
    func onSuccess() {
        self.removeSpinner()
        let bookingViewController = BookingSuccessViewController()
        navigationController?.pushViewController(bookingViewController, animated: true)
    }
    
    func onFailure() {
        self.removeSpinner()
        let bookingViewController = BookingSuccessViewController()
        navigationController?.pushViewController(bookingViewController, animated: true)
    }
}

extension AppointmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneWeekDateData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timeCollectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! AppointmentTimeCell
        cell.backView.layer.borderWidth = 1
        cell.backView.layer.borderColor = UIColor.black.cgColor
        cell.backView.layer.cornerRadius = 10
        cell.dateLabel.text = oneWeekDateData[indexPath.row].0
        cell.dayLabel.text = oneWeekDateData[indexPath.row].1
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = timeCollectionView.cellForItem(at: indexPath) as! AppointmentTimeCell
        cell.backView.backgroundColor = UIColor(named: "blue something 2")
        cell.dateLabel.textColor = .white
        cell.dayLabel.textColor = .white
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = timeCollectionView.cellForItem(at: indexPath) as! AppointmentTimeCell
        cell.backView.backgroundColor = .white
        cell.dayLabel.textColor = .gray
        cell.dateLabel.textColor = .gray
    }
}
