//
//  LoginViewModel.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 14/12/21.
//

import Foundation
import Alamofire
import UIKit

protocol LoginViewModelProtocol {
    func onSuccess()
    func onFailure()
}

class LoginViewModel {
    
    var delegate: LoginViewModelProtocol?
    var userData: UserModel?
    let userDefaults = UserDefaults()
    var emailU: String = ""
    var status: Bool = false
    
    func loginAPI(email:String, password: String ) {
        var params = ["email": "\(email)", "password": "\(password)"]
        
        Alamofire.request("https://medikuy.herokuapp.com/login", method: .post, parameters: params).responseJSON { (responseJson) in
            print("response json login adalah \(responseJson)")
            do{
                let decoder = JSONDecoder()
                let dataUser = try decoder.decode(UserModel.self, from: responseJson.data!)
                if dataUser.user == nil {
                    self.delegate?.onFailure()
                    
                } else {
                    DispatchQueue.main.async {
                        print("token user = \(dataUser.token)")
                        guard let token = dataUser.token else { return }
                        UserDefaults.standard.set(dataUser.user?.email, forKey: "email")
                        UserDefaults.standard.set(dataUser.user?.birthDate, forKey: "birthDate")
                        UserDefaults.standard.set(token, forKey: "token")
                        UserDefaults.standard.set(dataUser.user?.passwordDigest, forKey: "password")
                        UserDefaults.standard.set(dataUser.user?.gender, forKey: "gender")
                        UserDefaults.standard.set(dataUser.user?.phoneNumber, forKey: "phoneNumber")
                        UserDefaults.standard.set(dataUser.user?.fullName, forKey: "fullName")
                        UserDefaults.standard.set(dataUser.user?.id, forKey: "id")
                        UserDefaults.standard.set(dataUser.user?.imageData, forKey: "imageData")
                        self.emailU = email
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
