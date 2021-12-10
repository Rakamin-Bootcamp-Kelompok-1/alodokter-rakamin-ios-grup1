//
//  ArticleAllListViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/6/21.
//

import UIKit

struct ArticleModelDummy {
    var title: String
    var description: String
    var image: String
}

class ArticleAllListViewController: BaseViewController {
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var articleSearchBar: UISearchBar!
    
    let category = ["Keluarga", "Nutrisi", "Bayi", "Kehamilan", "Kecantikan", "Diabetes"]
    let articles: [ArticleModelDummy] = [ArticleModelDummy(title: "4 Manfaat Daun Sambiloto untuk Kulit yang Sayang Dilewatkan", description: "Tak hanya baik untuk kesehatan tubuh, manfaat daun sambiloto untuk kesehatan kulit pun begitu beragam. Berbagai kandungan nutrisi di dalamnya dipercaya baik", image: "article_pic_example1"), ArticleModelDummy(title: "Mengenal COVID-19 Varian Omicron", description: "Varian Omicron (B.1.1.529) merupakan salah satu hasil mutasi virus Corona. Berdasarkan bukti yang ada sejauh ini, varian Omicron memiliki tingkat mutasi yang tinggi", image: "article_pic_example2"), ArticleModelDummy(title: "4 Manfaat Daun Sambiloto untuk Kulit yang Sayang Dilewatkan", description: "Tak hanya baik untuk kesehatan tubuh, manfaat daun sambiloto untuk kesehatan kulit pun begitu beragam. Berbagai kandungan nutrisi di dalamnya dipercaya baik", image: "article_pic_example1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
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
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.backgroundColor = UIColor(named: "blue something")
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
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ArticleAllListCell", for: indexPath) as! ArticleAllListTableViewCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        cell.articleImageView.image = UIImage(named: articles[indexPath.row].image)
        return cell
    }
}
