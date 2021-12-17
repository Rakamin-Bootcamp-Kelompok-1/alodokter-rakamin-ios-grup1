//
//  ArticleDetailViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 13/12/21.
//

import Foundation

protocol ArticleDetailProtocol: NSObject{
    func reloadCollection()
    func displayContent(title: String, desc: String, thumb: URL?)
}

class ArticleDetailViewModel{
    private let adContentDetail = ArticleDetailService()
    private let adCollectionDetail = ArticleService()
    
    weak var delegate: ArticleDetailProtocol?
    var collectionModel = [ArticleModel]()
    
    func retriveData(id: Int){
        let url = URL(string: "https://medikuy.herokuapp.com/articles/\(id)")!
        
        Network.requestWithURL(req: adContentDetail, costumURL: url) { result in
            
            DispatchQueue.main.async { [self] in
                switch result{
                case .success(let result):
                    let r: ArticleModel = result
                    
                    var imgUrl: URL? = nil
                    
                    if let url = r.image_url {
                        imgUrl = URL(string: url)
                    }
                    delegate?.displayContent(title: r.article_title ?? "Tidak ada judul", desc: r.content_desc ?? "Tidak ada deskripsi", thumb: imgUrl)
                case .failure:
                    delegate?.displayContent(title: "Tidak ada judul", desc: "Tidak ada deskripsi", thumb: nil)
                }
            }
        }
    }
    
    func retriveCollection(id: Int){
        let url = URL(string: "https://medikuy.herokuapp.com/articles")!
        
        Network.requestWithURL(req: adCollectionDetail, costumURL: url) { result in
            
            DispatchQueue.main.async { [self] in
                switch result{
                case .success(let result):
                    var mod = [ArticleModel]()
                    
                    result.data.forEach { i in
                        if i.id != id{
                            mod.append(i)
                        }
                    }
                    collectionModel = mod
                case .failure:
                    break
                }
                delegate?.reloadCollection()
            }
        }
    }
}
