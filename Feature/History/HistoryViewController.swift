//
//  HistoryViewController.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 08/12/21.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    //    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    func setupView() {
//        historyTableView.register(UINib(nibName: HistoryItemCell.identifier, bundle: nil), forCellReuseIdentifier: HistoryItemCell.identifier)
//        historyTableView.delegate = self
//        historyTableView.dataSource = self
        userImg.layer.cornerRadius = userImg.frame.width / 2
        userImg.layer.masksToBounds = true
        doctorCollectionView.delegate = self
        doctorCollectionView.dataSource = self
        doctorCollectionView.register(UINib(nibName: HistoryItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: HistoryItemCell.identifier)
        self.view.layer.backgroundColor = UIColor.white.cgColor
        navigationItem.title = ""
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = .white
    }
    
    
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryItemCell.identifier, for: indexPath)
        cell.backgroundColor = .clear // very important
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.masksToBounds = true
//             add corner radius on `contentView`
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailHistoryViewController(nibName: DetailHistoryViewController.identifier, bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
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
