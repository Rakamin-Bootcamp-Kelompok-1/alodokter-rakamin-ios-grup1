//
//  PaymentSelectionViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/16/21.
//

import UIKit

struct PaymentPerCategory {
    var category: String?
    var payment: [Payment]?
}

struct Payment {
    var name: String?
    var image: String?
}

class PaymentSelectionViewController: UIViewController {
    @IBOutlet weak var paymentTableView: UITableView!
    
    let paymentsPerCategories: [PaymentPerCategory] = [
        PaymentPerCategory(category: "E Wallet", payment: [
            Payment(name: "Shoope", image: "shopee"),
            Payment(name: "OVO", image: "ovo"),
            Payment(name: "Gopay", image: "gopay")
        ]),
        PaymentPerCategory(category: "Transfer Virtual Account", payment: [
            Payment(name: "BCA", image: "bca"),
            Payment(name: "BRI", image: "bri")
        ]),
        PaymentPerCategory(category: "Asuransi", payment: [
            Payment(name: "AdMedika", image: "admedika"),
            Payment(name: "BPJS Kesehatan", image: "bpjs"),
            Payment(name: "Allianz", image: "allianz")
        ])
    ]
    
    var appointmentVC = AppointmentViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTalbeView()
    }
    
    private func initTalbeView() {
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        paymentTableView.register(UINib(nibName: "PaymentSelectionCell", bundle: nil), forCellReuseIdentifier: "PaymentCell")
    }
}

extension PaymentSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return paymentsPerCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return paymentsPerCategories[section].category
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (paymentsPerCategories[section].payment!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentSelectionCell
        cell.paymentImageView.image = UIImage(named: paymentsPerCategories[indexPath.section].payment![indexPath.row].image!)
        cell.paymentLabel.text = paymentsPerCategories[indexPath.section].payment![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appointmentVC.paymentLabel.text = paymentsPerCategories[indexPath.section].payment![indexPath.row].name
        appointmentVC.paymentImageView.image = UIImage(named: paymentsPerCategories[indexPath.section].payment![indexPath.row].image!)
        dismiss(animated: true)
    }
    
}
