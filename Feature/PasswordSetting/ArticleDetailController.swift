//
//  ArticleDetailController.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 09/12/21.
//

import UIKit

class ArticleDetailController: UIViewController {

    @IBOutlet weak var titleArticleDetail: UILabel!
    @IBOutlet weak var thumbnailArticleDetail: UIImageView!
    @IBOutlet weak var descriptionArticleDetail: UILabel!
    
    @IBOutlet weak var imageFacebook: UIImageView!
    @IBOutlet weak var imageTwitter: UIImageView!
    @IBOutlet weak var imageLinkedIn: UIImageView!
    @IBOutlet weak var imageWeb: UIImageView!
    
    @IBOutlet weak var buttonSeeAll: UIButton!
    @IBOutlet weak var collectionArticle: UICollectionView!
    @IBOutlet weak var pageControlArticle: UIPageControl!
    
    private var viewModel: ArticleDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        setClickableTargets()
        setCollection()
    }
    
    func setViewModel(){
        viewModel = ArticleDetailViewModel()
        viewModel.delegate = self
        viewModel.beginProccess()
    }
    
    func setCollection(){
        collectionArticle.delegate = self
        collectionArticle.dataSource = self
        collectionArticle.register(UINib(nibName: "ArticleDetailViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleDetailViewCell")
    }
    
    func setClickableTargets(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_ :)))
        imageFacebook.tag = 0
        imageFacebook.addGestureRecognizer(gesture)
        imageTwitter.tag = 1
        imageTwitter.addGestureRecognizer(gesture)
        imageLinkedIn.tag = 2
        imageLinkedIn.addGestureRecognizer(gesture)
        imageWeb.tag = 3
        imageWeb.addGestureRecognizer(gesture)
        
        buttonSeeAll.addTarget(self, action: #selector(handleButtonSeeAll(_ :)), for: .touchUpInside)
    }
    
}

extension ArticleDetailController{
    @objc func handleTapGesture(_ gesture : UITapGestureRecognizer)
    {
        let v = gesture.view!
        viewModel.linkToWeb(tag: v.tag)
    }
    
    @objc func handleButtonSeeAll(_ sender: UIButton){
        
    }
    
}
    
extension ArticleDetailController: ArticleDetailProtocol{
    
    func reloadCollection() {
        collectionArticle.reloadData()
    }
    
    func displayContent(title: String, desc: String, thumb: URL?) {
        titleArticleDetail.text = title
        descriptionArticleDetail.text = desc
        thumbnailArticleDetail.image = UIImage(named: "")
    }
    
    func displayWeb(url: URL?) {
        if let url = url {
            UIApplication.shared.open(url)
        }
    }
}

extension ArticleDetailController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.detailModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleDetailViewCell", for: indexPath) as! ArticleDetailCellController
        cell.titlePostArticleDetail.text = "lol"
        return cell
    }
    
    
}
