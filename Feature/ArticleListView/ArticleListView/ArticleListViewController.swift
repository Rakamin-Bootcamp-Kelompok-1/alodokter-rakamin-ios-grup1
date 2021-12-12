//
//  ArticleListViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/6/21.
//

import UIKit

class ArticleListViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var highlightArticleImageView: UIImageView!
    @IBOutlet weak var highlightArticleLabel: UILabel!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    @IBOutlet weak var doctorView: UIView!
    @IBOutlet weak var allArticleView: UIView!
    @IBOutlet weak var articleSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArticleCollectionView()
        viewSetup()
        
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
    }
    
    func initArticleCollectionView() {
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(UINib(nibName: "ArticleListCell", bundle: nil), forCellWithReuseIdentifier: "ArticleListCell")
        
    }
    
    @objc func viewAllArticle(_ sender: UIView) {
        let vc = ArticleAllListViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = articleCollectionView.dequeueReusableCell(withReuseIdentifier: "ArticleListCell", for: indexPath) as! ArticleListCell
        cell.nameLabel.text = "Article"
        cell.articleImageView.image = UIImage(named: "article_pic_example")
        return cell
    }
}
