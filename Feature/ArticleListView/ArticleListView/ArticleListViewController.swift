//
//  ArticleListViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/6/21.
//

import UIKit
import SDWebImage

class ArticleListViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var highlightArticleImageView: UIImageView!
    @IBOutlet weak var highlightArticleLabel: UILabel!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    @IBOutlet weak var doctorView: UIView!
    @IBOutlet weak var allArticleView: UIView!
    @IBOutlet weak var articleSearchBar: UISearchBar!
    
    var viewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArticleCollectionView()
        viewSetup()
        requestData()
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
        self.isNavigationBarHidden = true
        viewModel.delegate = self
        articleSearchBar.delegate = self
    }
    
    func initArticleCollectionView() {
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(UINib(nibName: "ArticleListCell", bundle: nil), forCellWithReuseIdentifier: "ArticleListCell")
        
    }
    
    func highlightArticleSetup() {
        let randomArticle = viewModel.articleListData[0].data.randomElement()
        highlightArticleImageView.sd_setImage(with: URL(string: randomArticle!.image_url ?? ""), placeholderImage: UIImage(named: "article_pic_example"))
        highlightArticleLabel.text = randomArticle!.article_title
    }
    
    func requestData(){
        self.showParentSpinner()
        viewModel.getArticleListData()
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
            return viewModel.articleListData[0].data.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = articleCollectionView.dequeueReusableCell(withReuseIdentifier: "ArticleListCell", for: indexPath) as! ArticleListCell
        cell.nameLabel.text = viewModel.articleListData[0].data[indexPath.row].article_title
        cell.articleImageView.sd_setImage(with: URL(string: viewModel.articleListData[0].data[indexPath.row].image_url ?? ""), placeholderImage: UIImage(named: "article_pic_example"))
        return cell
    }
}

extension ArticleListViewController: ArticleViewModelDelegate {
    func onSuccessRequest() {
        self.removeSpinner()
        highlightArticleSetup()
        articleCollectionView.reloadData()
    }
    
    func onErrorRequest() {
        self.removeSpinner()
    }
}
