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
        var params = ["full_name": "\(name)", "password": "\(password)", "email": "\(email)", "gender": "\(gender)", "birth_date": "\(birtdate)", "phone_number": "\(phone)"]

        Alamofire.request("https://medikuy.herokuapp.com/user/add", method: .post, parameters: params).responseJSON { (responseJson) in
            do{
                let decoder = JSONDecoder()
                let dataUser = try decoder.decode(UserModel.self, from: responseJson.data!)
                if dataUser.user == nil {
                    self.delegate?.onRegistered()
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
