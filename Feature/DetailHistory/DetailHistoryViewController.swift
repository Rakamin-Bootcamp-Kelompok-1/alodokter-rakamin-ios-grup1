//
//  DetailHistoryViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 09/12/21.
//

import UIKit

class DetailHistoryViewController: UIViewController {

    @IBOutlet weak var informationBookView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var paymentView: UIView!
    static let identifier = "DetailHistoryViewController"
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
        
        
        
        
        
        // Do any additional setup after loading the view.
    }


    

}
