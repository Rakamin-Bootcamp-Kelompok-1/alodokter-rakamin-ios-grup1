//
//  ArticleDetailViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 09/12/21.
//

import Foundation

protocol ArticleDetailProtocol: NSObject{
    func reloadCollection()
    func displayContent(title: String, desc: String, thumb: URL?)
    func displayWeb(url: URL?)
}

class ArticleDetailViewModel{
    
    weak var delegate: ArticleDetailProtocol?
    var detailModel = [String]()
    
    func linkToWeb(tag: Int){
        var urlString = "www"
        switch tag{
        case 1: urlString = "www"
        case 2: urlString = "www"
        case 3: urlString = "www"
        default: break
        }
        delegate?.displayWeb(url: URL(string: urlString))
    
    }
    
    func beginProccess(){
        retriveData()
        retriveCollection()
    }
    
    private func retriveData(){
        delegate?.displayContent(title: "Contoh Judul", desc: "Contoh isi aja", thumb: nil)
    }
    
    private func retriveCollection(){
        detailModel = []
        delegate?.reloadCollection()
    }
}
