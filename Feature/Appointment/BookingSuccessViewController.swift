//
//  BookingSuccessViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/18/21.
//

import UIKit

class BookingSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func backToHome(_ sender: Any) {
        let tabBarController = TabBarViewController()
        navigationController?.popToRootViewController(animated: true)
    }
}
