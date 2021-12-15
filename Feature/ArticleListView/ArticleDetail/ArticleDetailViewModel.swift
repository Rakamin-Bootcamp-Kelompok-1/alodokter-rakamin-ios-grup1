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
        let title = "4 Manfaat Daun Sambiloto untuk Kulit yang Sayang Dilewatkan"
        let desc = "Tak hanya baik untuk kesehatan tubuh, manfaat daun sambiloto untuk kesehatan kulit pun begitu beragam. Berbagai kandungan nutrisi di dalamnya dipercaya baik untuk mencegah infeksi pada kulit dan melindungi kulit dari bahaya radikal bebas. \nDaun sambiloto (Andrographis paniculata) adalah salah satu tanaman obat tradisional yang banyak dibudidayakan di berbagai negara Asia, termasuk Indonesia. Daun ini dipercaya dapat mengatasi berbagai masalah kesehatan, seperti gangguan fungsi hati, penyakit jantung, alergi, hingga infeksi."
        delegate?.displayContent(title: title, desc: desc, thumb: nil)
    }
    
    private func retriveCollection(){
        detailModel = []
        delegate?.reloadCollection()
    }
}
