//
//  DetailConsultDoctorViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import UIKit

class DetailConsultDoctorViewController: UIViewController {

    @IBOutlet weak var bioView: UIView!
    
    @IBOutlet weak var eduCollectionView: UICollectionView!
    @IBOutlet weak var eduView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var doctorPreviewLbl: UILabel!
    static let identifier = "DetailConsultDoctorViewController"
    var preview = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        eduCollectionView.delegate = self
        eduCollectionView.dataSource = self
        navigationItem.title = "Detail Dokter"
        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        bioView.layer.shadowColor = UIColor.gray.cgColor
        bioView.layer.shadowOpacity = 0.3
        bioView.layer.shadowOffset = CGSize.zero
        bioView.layer.shadowRadius = 6
        bioView.layer.cornerRadius = 8
        
        eduView.layer.shadowColor = UIColor.gray.cgColor
        eduView.layer.shadowOpacity = 0.3
        eduView.layer.shadowOffset = CGSize.zero
        eduView.layer.shadowRadius = 6
        eduView.layer.cornerRadius = 8
        
//        scheduleView.layer.shadowColor = UIColor.gray.cgColor
//        scheduleView.layer.shadowOpacity = 0.3
//        scheduleView.layer.shadowOffset = CGSize.zero
//        scheduleView.layer.shadowRadius = 6
//        scheduleView.layer.cornerRadius = 8
        
        let readmoreFont = UIFont.systemFont(ofSize: 9)
        let readmoreFontColor = UIColor.blue
        DispatchQueue.main.async {
            self.doctorPreviewLbl.addTrailing(with: "...", moreText: "Read More", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
            
        }
        doctorPreviewLbl.text = preview
    }
    
    func registerCell() {
        eduCollectionView.register(UINib(nibName: EducationDocCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: EducationDocCollectionViewCell.identifier)
    }


    @IBAction func tapPreview(_ sender: UITapGestureRecognizer) {
        guard let text = doctorPreviewLbl.text else {
            print("masuk else")
            return
            
        }
        
        let readmore = (text as NSString).range(of: "...Read More")
        let readless = (text as NSString).range(of: "Read Less")
        print("read less = \(readless)")
        if sender.didTap(label: doctorPreviewLbl, inRange: readmore) {
            print("masuk readmore")
            doctorPreviewLbl.appendReadLess(after: preview, trailingContent: ".")
        }else if sender.didTap(label: doctorPreviewLbl, inRange: readless) {
            doctorPreviewLbl.appendReadmore(after: preview, trailingContent: "Read More")
        }else{
            print("tidak ada sender yg cocok \(sender)")
            return
        }
    }
    

}

extension DetailConsultDoctorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EducationDocCollectionViewCell.identifier, for: indexPath) as? EducationDocCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
