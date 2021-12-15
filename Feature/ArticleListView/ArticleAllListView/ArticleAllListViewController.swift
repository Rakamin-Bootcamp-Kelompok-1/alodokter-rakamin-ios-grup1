//
//  ArticleAllListViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/6/21.
//

import UIKit

class ArticleAllListViewController: BaseViewController {
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var articleSearchBar: UISearchBar!
    
    let viewModel = ArticleViewModel()
    let category = ["Keluarga", "Nutrisi", "Bayi", "Kehamilan", "Kecantikan", "Diabetes"]
    var articles: [ArticleModel] = []
    var articlePages = 1
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        getArticleData(page: articlePages)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationBarVisibility(hide: false)
    }
    
    func viewSetup() {
        kategoriCollectionView.delegate = self
        kategoriCollectionView.dataSource = self
        kategoriCollectionView.register(UINib(nibName: "ArticleAllListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleAllListCell")
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.register(UINib(nibName: "ArticleAllListTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleAllListCell")
        articleTableView.rowHeight = UITableView.automaticDimension
        articleSearchBar.backgroundImage = UIImage()
        self.navigationItem.title = "Medikuy Artikel"
        viewModel.delegate = self
    }
    
    func getArticleData(page: Int) {
        self.showParentSpinner()
        viewModel.getArticleListDataWithUrl(customUrl: URL(string: "https://medikuy.herokuapp.com/articles?page=\(page)")!)
    }
}

extension ArticleAllListViewController: ArticleViewModelDelegate {
    func onSuccessRequest() {
        self.articles.append(contentsOf: viewModel.articleListData[0].data)
        self.articleTableView.reloadData()
        self.removeSpinner()
    }
    
    func onErrorRequest() {
        self.removeSpinner()
    }
    
    
}

extension ArticleAllListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = kategoriCollectionView.dequeueReusableCell(withReuseIdentifier: "ArticleAllListCell", for: indexPath) as! ArticleAllListCollectionViewCell
        cell.categoryLabel.text = category[indexPath.row]
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        return cell
    }
}

extension ArticleAllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ArticleAllListCell", for: indexPath) as! ArticleAllListTableViewCell
        cell.titleLabel.text = articles[indexPath.row].article_title
        cell.descriptionLabel.text = articles[indexPath.row].content_desc
        cell.articleImageView.sd_setImage(with: URL(string: articles[indexPath.row].image_url ?? ""), placeholderImage: UIImage(named: "article_pic_example"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == articles.count {
            if articlePages < 2 {
                articlePages += 1
                getArticleData(page: articlePages)
            }
        }
    }
}
