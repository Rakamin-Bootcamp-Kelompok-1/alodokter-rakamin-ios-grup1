//
//  EditProfileViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 18/12/21.
//

import Foundation
import Alamofire

protocol editProfileViewModelDelegate {
//    func onUpdatePatch()
    func onSuccessPatch()
    func onErrorPatch()
}

class EditProfileViewModel {
    var userService = EditProfileService()
    var userData: UserModel?
    var delegate: editProfileViewModelDelegate?
    let userDefaults = UserDefaults()
    
    func editProfile(fullName: String, email: String, birthDate: String, phoneNumber: String) {
//        userService.token = "\(userDefaults.value(forKey: "token")!)"
        let parameters = ["full_name": "\(fullName)", "email": "\(email)", "birth_date": "\(birthDate)", "phone_number": "\(phoneNumber)"]
        
        userService.parameterp = parameters
        print("header \(userService.setHeaders())")
        print("id user \(userDefaults.value(forKey: "id") ?? "")")
        print("body \(userService.setParameters())")
        Network.request(req: userService) {[weak self] (result) in
            switch result {
                
            case .success(let data):
                print("sukses")
            case .failure(let error):
                print("errornya =\(error)")
            }
        }
//        Alamofire.request("https://medikuy.herokuapp.com/user/update/\(userDefaults.value(forKey: "id") ?? "")", method: .patch, parameters: parameters).responseJSON { responseJson in
//            print("response \(responseJson)")
//            do {
//                let decoder = JSONDecoder()
//                let dataUser = try decoder.decode(UserModel.self, from: responseJson.data!)
////
////                if dataUser.user == nil {
////                    self.delegate?.onUpdatePatch()
////                } else {
////                    DispatchQueue.main.async {
////                        self.delegate?.onSuccessPatch()
////                    }
////                }
//
//                if dataUser.user != nil {
//                    DispatchQueue.main.async {
//                        self.delegate?.onSuccessPatch()
//                    }
//                }
      
                if dataUser.user != nil {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(dataUser.user?.fullname, forKey: "fullName")
                        UserDefaults.standard.set(dataUser.user?.email, forKey: "email")
                        UserDefaults.standard.set(dataUser.user?.birthDate, forKey: "birthDate")
                        UserDefaults.standard.set(dataUser.user?.phoneNumber, forKey: "phoneNumber")
                        self.delegate?.onSuccessPatch()
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.onErrorPatch()
                }
            }

        }

    }
    
}
