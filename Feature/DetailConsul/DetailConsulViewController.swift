//
//  DetailConsulViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

class DetailConsulViewController: BaseViewController {

    static let identifier = "DetailConsulViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail Dokter"
        navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
    }

}
