//
//  ConsulViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

class ConsulViewController: UIViewController {

    @IBOutlet weak var doctorCollectionvView: UICollectionView!
    @IBOutlet weak var specialistCollectionView: UICollectionView!
    var viewModel = ConsulDoctorViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        specialistCollectionView.delegate = self
        specialistCollectionView.dataSource = self
        doctorCollectionvView.delegate = self
        doctorCollectionvView.dataSource = self
        viewModel.delegate = self
        viewModel.getDoctorList()
        registerCell()
        navigationItem.title = ""
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = .white
    }

    func registerCell() {
        specialistCollectionView.register(UINib(nibName: SpecialistCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SpecialistCollectionViewCell.identifier)
        doctorCollectionvView.register(UINib(nibName: DoctorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DoctorCollectionViewCell.identifier)
    }

}

extension ConsulViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case specialistCollectionView:
                return 5
            case doctorCollectionvView:
                return viewModel.doctorList.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case specialistCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialistCollectionViewCell.identifier, for: indexPath) as? SpecialistCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case doctorCollectionvView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorCollectionViewCell.identifier, for: indexPath) as? DoctorCollectionViewCell else {return UICollectionViewCell() }
            cell.backgroundColor = .clear // very important
            cell.layer.masksToBounds = false
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowRadius = 4
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.setup(doctor: viewModel.doctorList[indexPath.row])
    //             add corner radius on `contentView`
            collectionView.backgroundColor = .white
            collectionView.layer.cornerRadius = 5
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension ConsulViewController: ConsulDoctorProtocol {
    func onSuccessDoctor() {
        self.doctorCollectionvView.reloadData()
    }
    
    func onFailureDoctor() {
        print("gagal")
    }
    
    
}
