//
//  DetailConsulViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

class DetailConsulViewController: BaseViewController {

    @IBOutlet weak var contentBio: UIView!
    @IBOutlet weak var backgroundBio: UIView!
    static let identifier = "DetailConsulViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail Dokter"
        navigationController?.navigationBar.isHidden = false
        contentBio.backgroundColor = .clear
        backgroundBio.layer.shadowColor = UIColor.gray.cgColor
        backgroundBio.layer.shadowOpacity = 0.3
        backgroundBio.layer.shadowOffset = CGSize.zero
        backgroundBio.layer.shadowRadius = 6
//        backgroundBio.layer.shadowColor = UIColor.black.cgColor
//        backgroundBio.layer.shadowOpacity = 0.2
//        backgroundBio.layer.shadowOffset = .zero
//        backgroundBio.layer.shadowRadius = 1
//
//        backgroundBio.layer.shouldRasterize = true
//        backgroundBio.layer.rasterizationScale = true ? UIScreen.main.scale : 1
        

        // Do any additional setup after loading the view.
    }

}
