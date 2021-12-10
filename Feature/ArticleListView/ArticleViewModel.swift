//
//  ArticleViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import Foundation

protocol ArticleViewModelDelegate {
    func onSuccessRequest()
    func onErrorRequest()
}

class ArticleViewModel {
    var articleService = ArticleService()
    var articleListData = [ArticleModel]()
    var delegate: ArticleViewModelDelegate?
    
    func getArticleListData(){
        Network.request(req: articleService) { (result) in
            switch result{
            case.success(let successGetData):
                self.articleListData.append(successGetData)
                self.articleListData.append(successGetData)
                self.articleListData.append(successGetData)
                self.delegate?.onSuccessRequest()
            case .failure(let error):
                self.delegate?.onErrorRequest()
            }
        }
    }
}
