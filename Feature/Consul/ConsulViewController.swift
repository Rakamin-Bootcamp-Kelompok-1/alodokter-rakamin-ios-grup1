//
//  ConsulViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

class ConsulViewController: BaseViewController {

    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var searchDoctor: UISearchBar!
    @IBOutlet weak var doctorCollectionvView: UICollectionView!
    @IBOutlet weak var specialistCollectionView: UICollectionView!
    var pageData = "1"
    var viewModel = ConsulDoctorViewModel()
    let userDefaults = UserDefaults()
    var profileViewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        specialistCollectionView.delegate = self
        specialistCollectionView.dataSource = self
        doctorCollectionvView.delegate = self
        doctorCollectionvView.dataSource = self
        
        viewModel.delegate = self
        
        viewModel.getDoctorList(page: pageData)
        
        profileView.userImageButton.addTarget(self, action: #selector(presentToProfileViewController), for: .touchUpInside)
        
        self.showParentSpinner()
        
        searchDoctor.delegate = self
        
        registerCell()
        
        navigationItem.title = ""
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = .white
    }

    func registerCell() {
        specialistCollectionView.register(UINib(nibName: SpecialistCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SpecialistCollectionViewCell.identifier)
        doctorCollectionvView.register(UINib(nibName: DoctorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DoctorCollectionViewCell.identifier)
    }
    
    @objc func presentToProfileViewController(button: UIButton) {
        let userDefaultLogin = UserDefaults()
        print("token =\(userDefaults.value(forKey: "token") ?? "")")
        if userDefaultLogin.value(forKey: "token") == nil {
            print("masuk token nil")
            let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } else {
            print("masuk token tidak nil")
            let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
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
            if indexPath.row + 1 == viewModel.doctorList.count {
                if viewModel.meta.nextPage != nil {
                   
                    var nextPage = "\(viewModel.meta.nextPage!)"
                    print("next page \(nextPage)")
                    viewModel.getDoctorList(page: nextPage)
                }
            }
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
