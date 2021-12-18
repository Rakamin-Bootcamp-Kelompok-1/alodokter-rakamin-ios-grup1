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
    let category = ["Kesehatan", "Keluarga", "Hidup Sehat"]
    var articles: [ArticleModel] = []
    var articlePages = 1
    var isSearchResult = false
    var isGotSearchByHome = false
    var searchKeywordByHome = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        
        if isGotSearchByHome == true {
            getArticleDataBySearch(search: searchKeywordByHome)
        } else {
            getArticleData(page: articlePages)
        }
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
        self.navigationItem.title = "Artikel MediKuy"
        viewModel.delegate = self
        articleSearchBar.delegate = self
    }
    
    func getArticleData(page: Int) {
        self.showParentSpinner()
        self.viewModel.articleListData.removeAll()
        viewModel.getArticleListDataWithUrl(customUrl: URL(string: "https://medikuy.herokuapp.com/articles?page=\(page)")!)
    }
    
    func getArticleDataBySearch(search: String) {
        self.showParentSpinner()
        articles.removeAll()
        articleTableView.reloadData()
        viewModel.articleListData.removeAll()
        if search == "" {
            isSearchResult = false
            articlePages = 1
            viewModel.getArticleListData()
        } else {
            isSearchResult = true
            viewModel.getArticleListDataWithUrlandBody(customUrl: URL(string: "https://medikuy.herokuapp.com/article/search")!, body: ["article_title": search])
        }
    }
    
    func getArticleDataByCategory(index: Int) {
        self.showParentSpinner()
        articles.removeAll()
        articleTableView.reloadData()
        viewModel.articleListData.removeAll()
        isSearchResult = true
        viewModel.getArticleListDataWithUrlandBody(customUrl: URL(string: "https://medikuy.herokuapp.com/article/category")!, body: ["article_category": category[index]])
    }
}

extension ArticleAllListViewController: ArticleViewModelDelegate {
    func onSuccessRequest() {
        self.articles.append(contentsOf: viewModel.articleListData[0].data)
        self.articleTableView.reloadData()
        self.removeSpinner()
    }
    
    func onErrorRequest() {
        self.articleTableView.reloadData()
        self.removeSpinner()
    }
}

extension ArticleAllListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getArticleDataBySearch(search: articleSearchBar.text ?? "")
    }
}

extension ArticleAllListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = kategoriCollectionView.dequeueReusableCell(withReuseIdentifier: "ArticleAllListCell", for: indexPath) as! ArticleAllListCollectionViewCell
        cell.categoryLabel.text = category[indexPath.row]
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getArticleDataByCategory(index: indexPath.row)
    }
}

extension ArticleAllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ArticleAllListCell", for: indexPath) as! ArticleAllListTableViewCell
        cell.selectionStyle = .none
        cell.titleLabel.text = articles[indexPath.row].article_title ?? "Article title is empty"
        cell.descriptionLabel.text = articles[indexPath.row].content_desc ?? "Article content is empty"
        cell.articleImageView.sd_setImage(with: URL(string: articles[indexPath.row].image_url ?? ""), placeholderImage: UIImage(named: "article_pic_example"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = articles[indexPath.row].id ?? 1
        let vc = ArticleDetailViewController()
        vc.articleID = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isSearchResult == false {
            if indexPath.row + 1 == articles.count {
                if articlePages < 4 {
                    articlePages += 1
                    getArticleData(page: articlePages)
                }
            }
        }
    }
}
