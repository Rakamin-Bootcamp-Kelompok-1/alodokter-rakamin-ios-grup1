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
        let parameters = ["full_name": "\(fullName)", "email": "\(email)", "birth_date": "\(birthDate)", "phone_number": "\(phoneNumber)"]
        userService.parameterp = parameters
        print("header \(userService.setHeaders())")
        print("id user \(userDefaults.value(forKey: "id") ?? "")")
        print("body \(userService.setParameters() ?? [:])")
        Network.request(req: userService) {[weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    UserDefaults.standard.set(data.fullName, forKey: "fullName")
                    UserDefaults.standard.set(data.email, forKey: "email")
                    UserDefaults.standard.set(data.birthDate, forKey: "birthDate")
                    UserDefaults.standard.set(data.phoneNumber, forKey: "phoneNumber")
                    self?.delegate?.onSuccessPatch()
                    print("sukses")
                }
            case .failure(let error):
                print("errornya =\(error)")
            }
        }
    }
}
