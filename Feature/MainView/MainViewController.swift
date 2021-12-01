//
//  MainViewController.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import UIKit
import SDWebImage

class MainViewController: BaseViewController {
    @IBOutlet weak var albumsTableView: UITableView!
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setupDelegate()
        requestData()
    }
    
}

// MARK: - Setup
extension MainViewController {
    private func setupDelegate(){
        viewModel.delegate = self
    }
    
    private func initTableView(){
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        albumsTableView.rowHeight = UITableView.automaticDimension
        albumsTableView.register(UINib(nibName: "AlbumsCell", bundle: nil), forCellReuseIdentifier: "AlbumsCell")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dummyAlbumListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsCell", for: indexPath) as! AlbumsCell
        cell.titleLabel.text = viewModel.dummyAlbumListData[indexPath.row].title
        cell.albumsImageView.sd_setImage(with: URL(string: viewModel.dummyAlbumListData[indexPath.row].url ?? ""), placeholderImage: UIImage(named: "ss"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: mainViewModelDelegate {
    func onSuccessRequest() {
        self.removeSpinner()
        albumsTableView.reloadData()
    }
    
    func onErrorRequest() {
        self.removeSpinner()
    }
}

// MARK: - Functions
extension MainViewController {
    func requestData(){
        self.showParentSpinner()
        viewModel.getDummyAlbums()
    }
}
