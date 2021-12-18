//
//  ArticleDetailViewController.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 14/12/21.
//

import UIKit
import SDWebImage

class ArticleDetailViewController: BaseViewController {
    
    var articleID: Int = 1
    
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adThumbImage: UIImageView!
    @IBOutlet weak var adDescLabel: UILabel!
    @IBOutlet weak var adStackImage1: UIImageView!
    @IBOutlet weak var adStackImage2: UIImageView!
    @IBOutlet weak var adStackImage3: UIImageView!
    @IBOutlet weak var adStackImage4: UIImageView!
    @IBOutlet weak var adSeeAllButton: UIButton!
    @IBOutlet weak var adPostCollection: UICollectionView!
    @IBOutlet weak var adPageControl: UIPageControl!
    
    private var viewModel: ArticleDetailViewModel!
    
    private var randomPHImage: UIImage?{
        let base = "article_pic_example"
        let selected = ["\(base)", "\(base)1", "\(base)2", "\(base)3"].randomElement()!
        return UIImage(named: selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
        setClickableTargets()
        setCollection()
    }
    
    func setViewModel(){
        self.showParentSpinner()
        viewModel = ArticleDetailViewModel()
        viewModel.delegate = self
        viewModel.retriveData(id: articleID)
        viewModel.retriveCollection(id: articleID)
    }
    
    func setCollection(){
        adPostCollection.delegate = self
        adPostCollection.dataSource = self
        adPostCollection.register(UINib(nibName: "ArticleDetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ArticleDetailCollectionCell")
        adPageControl.numberOfPages = 1
    }
    
    func setClickableTargets(){
        let gest1 = UITapGestureRecognizer(target: self, action: #selector(didTapFb(_ :)))
        adStackImage1.isUserInteractionEnabled = true
        adStackImage1.addGestureRecognizer(gest1)
        
        let gest2 = UITapGestureRecognizer(target: self, action: #selector(didTapTwit(_ :)))
        adStackImage2.isUserInteractionEnabled = true
        adStackImage2.addGestureRecognizer(gest2)
        
        let gest3 = UITapGestureRecognizer(target: self, action: #selector(didTapIn(_ :)))
        adStackImage3.isUserInteractionEnabled = true
        adStackImage3.addGestureRecognizer(gest3)
        
        let gest4 = UITapGestureRecognizer(target: self, action: #selector(didTapLink(_ :)))
        adStackImage4.isUserInteractionEnabled = true
        adStackImage4.addGestureRecognizer(gest4)
        
        adSeeAllButton.addTarget(self, action: #selector(handleButtonSeeAll(_ :)), for: .touchUpInside)
    }
    
}

extension ArticleDetailViewController{
    
    @objc func didTapFb(_ gesture: UITapGestureRecognizer){
        openURl("https://www.facebook.com")
    }
    
    @objc func didTapTwit(_ gesture: UITapGestureRecognizer){
        openURl("https://twitter.com")
    }
    
    @objc func didTapIn(_ gesture: UITapGestureRecognizer){
        openURl("https://www.linkedin.com")
       
    }
    
    @objc func didTapLink(_ gesture: UITapGestureRecognizer){
        openURl("https://rakamin.com")
        
    }
    
    @objc func handleButtonSeeAll(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func openURl(_ urlString: String){
        let url = URL(string: urlString)
        if let url = url {
            UIApplication.shared.open(url)
        }
    }
    
}
    
extension ArticleDetailViewController: ArticleDetailProtocol{
    
    func reloadCollection() {
        adPostCollection.reloadData()
        adPageControl.numberOfPages = viewModel.collectionModel.count
    }
    
    func displayContent(title: String, desc: String, thumb: URL?) {
        self.removeSpinner()
        self.adTitleLabel.text = title
        self.adDescLabel.text = desc
        adThumbImage.sd_setImage(with: thumb, placeholderImage: randomPHImage)
    }
    
}

extension ArticleDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / view.frame.width
        adPageControl.currentPage = Int(scrollPosition)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleDetailCollectionCell", for: indexPath) as! ArticleDetailCollectionCell
        let item = viewModel.collectionModel[indexPath.row]
        
        var imgUrl: URL? = nil
        
        if let url = item.image_url {
            imgUrl = URL(string: url)
        }
        
        cell.adCellTitleLabel.text = item.article_title
        cell.adCellThumbImage.sd_setImage(with: imgUrl, placeholderImage: randomPHImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.collectionModel[indexPath.row].id ?? 1
        let vc = ArticleDetailViewController()
        vc.articleID = item
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
    
}
