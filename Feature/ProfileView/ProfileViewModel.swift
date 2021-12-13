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
    
    func getUser() {
        Network.requestNoBody(req: userService) { result in
            switch result {
            case.success(let successGetData):
//                self.userData?.id = successGetData.id
//                self.userData?.fullname = successGetData.fullname
//                self.userData?.password = successGetData.password
//                self.userData?.age = successGetData.age
//                self.userData?.email = successGetData.email
//                self.userData?.gender = successGetData.gender
//                self.userData?.birthDate = successGetData.birthDate
//                self.userData?.phoneNumber = successGetData.phoneNumber
//                self.userData?.imagePath = successGetData.imagePath
//                self.userData?.isAdmin = successGetData.isAdmin
//                self.userData?.isActive = successGetData.isActive
//                self.userData?.createdAt = successGetData.createdAt
//                self.userData?.updatedAt = successGetData.updatedAt
                
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
