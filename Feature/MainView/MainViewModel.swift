//
//  MainViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation

protocol mainViewModelDelegate {
    func onSuccessRequest()
    func onErrorRequest()
}

class MainViewModel {
    var dummyAlbumService = DummyAlbumsService()
    var dummyAlbumListData = [DummyAlbumsModel]()
    var delegate : mainViewModelDelegate?
    
    func getDummyAlbums(){
        Network.request(req: dummyAlbumService) { (result) in
            switch result{
            case.success(let successGetData):
                self.dummyAlbumListData.append(successGetData)
                self.dummyAlbumListData.append(successGetData)
                self.dummyAlbumListData.append(successGetData)
                self.delegate?.onSuccessRequest()
            case .failure(let error):
                self.delegate?.onErrorRequest()
            }
        }
    }
    
}
