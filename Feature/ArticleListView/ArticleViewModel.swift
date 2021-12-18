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
    var articleListData = [ArticleData]()
    var delegate: ArticleViewModelDelegate?
    
    func getArticleListData() {
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
    
    func getArticleListDataWithUrl(customUrl: URL){
        Network.requestWithURL(req: articleService, costumURL: customUrl) { (result) in
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
    
    func getArticleListDataWithUrlandBody(customUrl: URL, body: [String: Any]) {
        Network.requestWithURLandBody(req: articleService, costumURL: customUrl, body: body) { result in
            switch result {
            case .success(let successGetData):
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
