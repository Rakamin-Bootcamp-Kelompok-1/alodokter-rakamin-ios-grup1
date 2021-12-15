//
//  PasswordForgotViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 15/12/21.
//

import Foundation

protocol PasswordForgotProtocol: NSObject{
    func updateView()
}

class PasswordForgotViewModel{
    weak var delegate: PasswordForgotProtocol?
    
    func beginVerification(){
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0) { [self] in
            delegate?.updateView()
        }
    }
}
