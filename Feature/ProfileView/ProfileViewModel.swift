//
//  ProfileViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

protocol profileViewModelDelegate {
    func onSuccessRequest()
    func onErrorRequest()
}

class ProfileViewModel {
    var userService = UserService()
    var userData: UserModel?
    var delegate: profileViewModelDelegate?
    let userDefaults = UserDefaults()
    
    func getUser() {
        Network.requestNoBody(req: userService) { result in
            switch result {
            case.success(let successGetData):
                DispatchQueue.main.async {
                    self.userData = successGetData
                    self.delegate?.onSuccessRequest()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onErrorRequest()
                }
            }
        }
    }
    
}
