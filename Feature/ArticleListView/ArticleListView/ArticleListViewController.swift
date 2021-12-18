//
//  ArticleListViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/6/21.
//

import UIKit
import SDWebImage

class ArticleListViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var highlightArticleImageView: UIImageView!
    @IBOutlet weak var highlightArticleLabel: UILabel!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    @IBOutlet weak var doctorView: UIView!
    @IBOutlet weak var allArticleView: UIView!
    @IBOutlet weak var articleSearchBar: UISearchBar!
    
    var userDefaults = UserDefaults()
    var viewModel = ArticleViewModel()
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArticleCollectionView()
        viewSetup()
        requestData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestData()
        print("masuk sini setelah login user default \(userDefaults.value(forKey: "token"))")
        profileView.userNameLabel.text = "\(userDefaults.value(forKey: "fullName") ?? "User") 👋"
    }
    
    func viewSetup() {
        doctorView.layer.shadowOffset = .zero
        doctorView.layer.shadowColor = UIColor.black.cgColor
        doctorView.layer.shadowOpacity = 0.5
        doctorView.layer.shadowRadius = 2
        doctorView.layer.cornerRadius = 20
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewAllArticle(_:)))
        tapGesture.delegate = self
        allArticleView.addGestureRecognizer(tapGesture)
        articleSearchBar.backgroundImage = UIImage()
        profileView.userNameLabel.text = "\(userDefaults.value(forKey: "fullName") ?? "User") 👋"
        profileView.userImageButton.addTarget(self, action: #selector(presentToProfileViewController), for: .touchUpInside)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(viewArticle(_:)))
        tapGesture2.delegate = self
        highlightArticleImageView.isUserInteractionEnabled = true
        highlightArticleImageView.addGestureRecognizer(tapGesture2)
        self.isNavigationBarHidden = true
        viewModel.delegate = self
        articleSearchBar.delegate = self
    }
    
    func initArticleCollectionView() {
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(UINib(nibName: "ArticleListCell", bundle: nil), forCellWithReuseIdentifier: "ArticleListCell")
        
    }
    
    @objc func viewArticle(_ sender: UIImageView) {
        let item = 10
        let vc = ArticleDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.articleID = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestData(){
        self.showParentSpinner()
        viewModel.getArticleListData()
//        profileViewModel.getUser()
    }
    
    @objc func presentToProfileViewController(button: UIButton) {
        
        var userDefaultLogin = UserDefaults()
        print("token =\(userDefaults.value(forKey: "token"))")
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
    
    @objc func viewAllArticle(_ sender: UIView) {
        let vc = ArticleAllListViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = ArticleAllListViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.isGotSearchByHome = true
        vc.searchKeywordByHome = articleSearchBar.text ?? ""
        articleSearchBar.text = ""
        articleSearchBar.endEditing(true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.articleListData.count != 0 {
            return viewModel.articleListData[0].data.count - 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = articleCollectionView.dequeueReusableCell(withReuseIdentifier: "ArticleListCell", for: indexPath) as! ArticleListCell
        cell.nameLabel.text = viewModel.articleListData[0].data[indexPath.row + 1].article_title
        cell.articleImageView.sd_setImage(with: URL(string: viewModel.articleListData[0].data[indexPath.row + 1].image_url ?? ""), placeholderImage: UIImage(named: "article_pic_example"))
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.articleListData[0].data[indexPath.row].id ?? 1
        let vc = ArticleDetailViewController()
        vc.articleID = item
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleListViewController: ArticleViewModelDelegate {
    func onSuccessRequest() {
        self.removeSpinner()
        print("fullname = \(userDefaults.value(forKey: "token"))")
//        profileView.userNameLabel.text = "\(userDefaults.value(forKey: "fullName") ?? "User") 👋"
        highlightArticleImageView.sd_setImage(with: URL(string: viewModel.articleListData[0].data[0].image_url ?? ""), placeholderImage: UIImage(named: "article_pic_example"))
        highlightArticleLabel.text = viewModel.articleListData[0].data[0].article_title
        articleCollectionView.reloadData()
    }
    
    func onErrorRequest() {
        self.removeSpinner()
    }
}
