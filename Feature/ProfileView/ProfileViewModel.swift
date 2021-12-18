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
    
    func getUser(token: String) {
        userService.token = token
        Network.requestNoBody(req: userService) { result in
            switch result {
                
            case.success(let successGetData):
                DispatchQueue.main.async {
                    print("user profile \(successGetData)")
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

//class ProfileViewModel {
//    var userService = UserService()
//    var userData: UserModel?
//    var delegate: profileViewModelDelegate?
//    var userDefaults = UserDefaults()
//
//    func getUser(token: String) {
//
//        userService.token = token
//        print("header \(userService.setHeaders())")
//        print("token dalam userservice \(userService.token)")
//        Network.requestNoBody(req: userService) { [weak self](result) in
//            print("result \(result)")
//            switch result {
//
//            case .success(let data):
//                print("data user profile \(data)")
//            case .failure(let error):
//                print("errronya \(error)")
//            }
//        }
////        Network.requestNoBody(req: userService) { result in
////            print("result getUser\(result)")
////            switch result {
////            case.success(let successGetData):
////                DispatchQueue.main.async {
////                    self.userDefaults.setValue(successGetData.token, forKey: "token")
////                    self.userDefaults.setValue(successGetData.user?.id, forKey: "id")
////                    self.userDefaults.setValue(successGetData.user?.fullname, forKey: "fullName")
////                    self.userDefaults.setValue(successGetData.user?.age, forKey: "age")
////                    self.userDefaults.setValue(successGetData.user?.email, forKey: "email")
////                    self.userDefaults.setValue(successGetData.user?.gender, forKey: "gender")
////                    self.userDefaults.setValue(successGetData.user?.birthDate, forKey: "birthDate")
////                    self.userDefaults.setValue(successGetData.user?.phoneNumber, forKey: "phoneNumber")
////                    self.userDefaults.setValue(successGetData.user?.imageData, forKey: "imageData")
////                    self.userDefaults.setValue(successGetData.user?.isAdmin, forKey: "isAdmin")
////                    self.userDefaults.setValue(successGetData.user?.isActive, forKey: "isActive")
////                    self.userDefaults.setValue(successGetData.user?.createdAt, forKey: "createdAt")
////                    self.userDefaults.setValue(successGetData.user?.updatedAt, forKey: "updatedAt")
////
////                    self.userData = successGetData
////                    self.delegate?.onSuccessRequest()
////                }
////
////            case .failure(let error):
////                DispatchQueue.main.async {
////                    self.delegate?.onErrorRequest()
////                }
////            }
////        }
//    }
//
//}
