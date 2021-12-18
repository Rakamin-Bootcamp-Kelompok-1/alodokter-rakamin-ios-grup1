//
//  DetailConsultDoctorViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import UIKit
import SDWebImage

class DetailConsultDoctorViewController: BaseViewController {

    @IBOutlet weak var bioView: UIView!
    
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var educationLbl: UILabel!
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var eduCollectionView: UICollectionView!
    @IBOutlet weak var eduView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var doctorPreviewLbl: UILabel!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var priceRateLbl: UILabel!
    var viewModel = DetailConsulViewModel()
    var heightEdu = CGFloat()
    var doctorResource: DoctorResource!
    static let identifier = "DetailConsultDoctorViewController"
    var preview = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        eduCollectionView.delegate = self
        eduCollectionView.dataSource = self
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        viewModel.delegate = self
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
        heightEdu = eduView.frame.height
        print("height edu awal \(heightEdu)")
//        print("constraint \(eduView.constraints)")
        scheduleView.layer.shadowColor = UIColor.gray.cgColor
        scheduleView.layer.shadowOpacity = 0.3
        scheduleView.layer.shadowOffset = CGSize.zero
        scheduleView.layer.shadowRadius = 6
        scheduleView.layer.cornerRadius = 8
        
        let readmoreFont = UIFont.systemFont(ofSize: 9)
        let readmoreFontColor = UIColor.blue
        setupView()
        DispatchQueue.main.async {
            self.doctorPreviewLbl.addTrailing(with: "...", moreText: "Read More", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        viewModel.getDoctorSchedule(doctorId: String(doctorResource.id ?? 0) ?? "0")
//        setupView()
        
    }
    
    func setupView() {
//        self.educationLbl.text = doctorResource.education ?? "No available"
        self.doctorPreviewLbl.text = doctorResource.biography ?? "No Biography"
        self.doctorImg.sd_setImage(with: URL(string: doctorResource.imagePath ?? ""),placeholderImage:UIImage(named: "ic_dokter_umum"))
        self.specialityLbl.text = doctorResource.speciality ?? ""
        self.priceRateLbl.text = String(doctorResource.priceRate ?? 0) ?? "0"
        self.ratingLbl.text = doctorResource.star ?? "0"
        self.locationLbl.text = doctorResource.locationPractice ?? "No Available"
        self.doctorImg.layer.cornerRadius = 8
    }
    
    func registerCell() {
        eduCollectionView.register(UINib(nibName: EducationDocCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: EducationDocCollectionViewCell.identifier)
        scheduleCollectionView.register(UINib(nibName: SchedulesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SchedulesCollectionViewCell.identifier)
    }
    
    @IBAction func bookingButton(_ sender: Any) {
        let appointmentViewController = AppointmentViewController()
        appointmentViewController.doctorResource = doctorResource
        navigationController?.pushViewController(appointmentViewController, animated: true)
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
            doctorPreviewLbl.appendReadLess(after: doctorResource.biography ?? "", trailingContent: ".")
            print("height edu baru \(eduView.frame.height)")
            
//            self.eduView.frame = CGRect(x: 0, y: 0, width: self.eduView.frame.width, height: heightEdu)
//            self.eduCollectionView.reloadData()
//            print("height edu ditambah \(eduView.frame.height)")
            
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
        switch collectionView {
        case scheduleCollectionView:
            return viewModel.scheduleList.count ?? 0
        case eduCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case scheduleCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SchedulesCollectionViewCell.identifier, for: indexPath) as? SchedulesCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(schedule: viewModel.scheduleList[indexPath.row])
            return cell
        case eduCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EducationDocCollectionViewCell.identifier, for: indexPath) as? EducationDocCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EducationDocCollectionViewCell.identifier, for: indexPath) as? EducationDocCollectionViewCell else { return UICollectionViewCell() }
//        return cell
    }
    
    
}

extension DetailConsultDoctorViewController: DetailConsulProtocol {
    func onSuccessSchedules() {
        print("masuk sukses view controller")
        self.scheduleCollectionView.reloadData()
    }
    
    func onFailureSchedules() {
        print("error")
    }
    
    
}
