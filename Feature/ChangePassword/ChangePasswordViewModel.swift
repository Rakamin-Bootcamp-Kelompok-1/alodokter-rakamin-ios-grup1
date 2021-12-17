//
//  ChangePasswordViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 17/12/21.
//

import Foundation

protocol changePasswordViewModelDelegate {
    func onSuccessRequest()
    func onErrorRequest()
}

class ChangePasswordViewModel {
    var userData: UserModel?
    var delegate: changePasswordViewModelDelegate?
    let userDefaults = UserDefaults()
    
    func changePassword(password: String) {
        let changePasswordService = ChangePasswordService(password: password)
        Network.request(req: changePasswordService) { result in
            switch result {
            case.success(let successGetData):
                DispatchQueue.main.async {
                    self.userData = successGetData
                    self.delegate?.onSuccessRequest()
                    print(password)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onErrorRequest()
                }
            }
        }
    }
    
}
