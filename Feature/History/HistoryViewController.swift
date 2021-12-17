//
//  HistoryViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 08/12/21.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    var viewModel = HistoryBookingViewModel()
    //    @IBOutlet weak var historyTableView: UITableView!
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        viewModel.delegate = self
        viewModel.getHistory()
    }

    func setupView() {
//        historyTableView.register(UINib(nibName: HistoryItemCell.identifier, bundle: nil), forCellReuseIdentifier: HistoryItemCell.identifier)
//        historyTableView.delegate = self
//        historyTableView.dataSource = self
        doctorCollectionView.delegate = self
        doctorCollectionView.dataSource = self
        doctorCollectionView.register(UINib(nibName: HistoryItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: HistoryItemCell.identifier)
        profileView.userNameLabel.text = "\(userDefaults.value(forKey: "fullName") ?? "User") 👋"
        profileView.userImageButton.addTarget(self, action: #selector(presentToProfileViewController), for: .touchUpInside)
        self.view.layer.backgroundColor = UIColor.white.cgColor
        navigationItem.title = ""
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = .white
    }
    
    @objc func presentToProfileViewController(button: UIButton) {
        if userDefaults.value(forKey: "token") == nil {
            let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } else {
            let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    
    
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.historyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryItemCell.identifier, for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryItemCell.identifier, for: indexPath) as? HistoryItemCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear // very important
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.setup(history: viewModel.historyData[indexPath.row])
//             add corner radius on `contentView`
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailHistoryViewController(nibName: DetailHistoryViewController.identifier, bundle: nil)
        controller.dataHistory = viewModel.historyData[indexPath.row]
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width / 1, height: 95)
//    }
    
    
    
    
}

extension HistoryViewController: HistoryBookingProtocol {
    func onSuccessHistory() {
        self.doctorCollectionView.reloadData()
        print("sukses")
    }
    
    func onFailureHistory() {
        print("failure")
    }
    
    
}

//extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 12
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryItemCell.identifier, for: indexPath) as! HistoryItemCell
//
//        return cell
//    }
//
//
//}
