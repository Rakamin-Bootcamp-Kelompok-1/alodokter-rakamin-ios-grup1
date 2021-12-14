//
//  ArticleDetailViewController.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 14/12/21.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
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
        adPostCollection.delegate = self
        adPostCollection.dataSource = self
        adPostCollection.register(UINib(nibName: "ArticleDetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ArticleDetailCollectionCell")
    }
    
    func setClickableTargets(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_ :)))
        adStackImage1.tag = 0
        adStackImage1.addGestureRecognizer(gesture)
        adStackImage2.tag = 1
        adStackImage2.addGestureRecognizer(gesture)
        adStackImage3.tag = 2
        adStackImage3.addGestureRecognizer(gesture)
        adStackImage4.tag = 3
        adStackImage4.addGestureRecognizer(gesture)
        
        adSeeAllButton.addTarget(self, action: #selector(handleButtonSeeAll(_ :)), for: .touchUpInside)
    }
    
}

extension ArticleDetailViewController{
    @objc func handleTapGesture(_ gesture : UITapGestureRecognizer)
    {
        let v = gesture.view!
        viewModel.linkToWeb(tag: v.tag)
    }
    
    @objc func handleButtonSeeAll(_ sender: UIButton){
        
    }
    
}
    
extension ArticleDetailViewController: ArticleDetailProtocol{
    
    func reloadCollection() {
        adPostCollection.reloadData()
    }
    
    func displayContent(title: String, desc: String, thumb: URL?) {
        self.adTitleLabel.text = title
        self.adDescLabel.text = desc
        adThumbImage.image = UIImage(named: "")
    }
    
    func displayWeb(url: URL?) {
        if let url = url {
            UIApplication.shared.open(url)
        }
    }
}

extension ArticleDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / view.frame.width
        adPageControl.currentPage = Int(scrollPosition)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleDetailCollectionCell", for: indexPath) as! ArticleDetailCollectionCell
        cell.adCellTitleLabel.text = "kskladjklasd"
        return cell
    }
}
