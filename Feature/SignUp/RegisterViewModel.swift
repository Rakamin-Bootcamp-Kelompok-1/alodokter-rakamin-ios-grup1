//
//  RegisterViewModel.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 14/12/21.
//

import Foundation
import Alamofire

protocol RegisterViewModelProtocol {
    func onSuccess()
    func onFailure()
    func onRegistered()
}

class RegisterViewModel {
    
    var delegate: RegisterViewModelProtocol?
    var service = RegisterService()
    var userData: UserModel?
    
    func registerAPI(name:String, password: String, email:String, gender: String, birtdate:String, phone: String) {
        let params = ["full_name": "\(name)", "password": "\(password)", "email": "\(email)", "gender": "\(gender)", "birth_date": "\(birtdate)", "phone_number": "\(phone)"]

        Alamofire.request("https://medikuy.herokuapp.com/user/add", method: .post, parameters: params).responseJSON { (responseJson) in
            do{
                let decoder = JSONDecoder()
                let dataUser = try decoder.decode(UserModel.self, from: responseJson.data!)
                if dataUser.user == nil {
                    DispatchQueue.main.async {
                        guard let token = dataUser.token else { return }
                        UserDefaults.standard.set(dataUser.user?.email, forKey: "email")
                        UserDefaults.standard.set(dataUser.user?.birthDate, forKey: "birthDate")
                        UserDefaults.standard.set(token, forKey: "token")
                        UserDefaults.standard.set(dataUser.user?.gender, forKey: "gender")
                        UserDefaults.standard.set(dataUser.user?.phoneNumber, forKey: "phoneNumber")
                        UserDefaults.standard.set(dataUser.user?.fullName, forKey: "fullName")
                        UserDefaults.standard.set(dataUser.user?.imageData, forKey: "imageData")
                        
                        self.delegate?.onRegistered()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.onSuccess()
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.onFailure()
                }
            }

        }

    }

}
