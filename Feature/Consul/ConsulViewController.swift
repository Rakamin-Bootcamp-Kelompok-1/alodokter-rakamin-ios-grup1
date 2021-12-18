//
//  ConsulViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

class ConsulViewController: BaseViewController {

    @IBOutlet weak var searchDoctor: UISearchBar!
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
        self.showParentSpinner()
        searchDoctor.delegate = self
//        self.definesPresentationContext = true
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

extension ConsulViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case specialistCollectionView:
                return viewModel.specialty.count
            case doctorCollectionvView:
                if viewModel.searchDoctorList.count != 0 {
                    return viewModel.searchDoctorList.count
                }else {
                    return viewModel.doctorList.count
                }
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case specialistCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialistCollectionViewCell.identifier, for: indexPath) as? SpecialistCollectionViewCell else { return UICollectionViewCell() }
            cell.setup(speciality: viewModel.specialty[indexPath.row])
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
//            cell.setup(doctor: viewModel.doctorList[indexPath.row])
    //             add corner radius on `contentView`
            cell.setup(doctor: viewModel.searchDoctorList.count != 0 ? viewModel.searchDoctorList[indexPath.row] : viewModel.doctorList[indexPath.row])
            collectionView.backgroundColor = .white
            collectionView.layer.cornerRadius = 5
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == doctorCollectionvView {
            let controller = DetailConsultDoctorViewController(nibName: DetailConsultDoctorViewController.identifier, bundle: nil)
            controller.doctorResource = viewModel.doctorList[indexPath.row]
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }else if collectionView == specialistCollectionView {
            if viewModel.doctorList.count != 0 {
                viewModel.doctorList.removeAll()
            }
            viewModel.getDoctorBySpeciality(speciality: viewModel.specialty[indexPath.row].speciality)
            self.showParentSpinner()
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            print("masuk reset")
            viewModel.resetSearch()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            viewModel.searchDoctor(name: searchBar.text!)
            self.showParentSpinner()
        }
    }
    
    
}

extension ConsulViewController: ConsulDoctorProtocol {
    func onSuccessDoctorBySpeciality() {
        self.doctorCollectionvView.reloadData()
        self.removeSpinner()
    }
    
    func onFailureDoctorBySpeciality() {
        self.removeSpinner()
        print("error")
    }
    
    func onSuccessSearchDoctor() {
        self.doctorCollectionvView.reloadData()
        self.removeSpinner()
    }
    
    func onFailureSearchDoctor() {
        self.removeSpinner()
        print("error")
    }
    
    func onSuccessDoctor() {
        self.doctorCollectionvView.reloadData()
        self.removeSpinner()
    }
    
    func onFailureDoctor() {
        self.removeSpinner()
        print("gagal")
    }
    
    
}
