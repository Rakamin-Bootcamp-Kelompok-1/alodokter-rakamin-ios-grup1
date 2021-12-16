//
//  ConsulDoctorViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import Foundation

protocol ConsulDoctorProtocol {
    func onSuccessDoctor()
    func onFailureDoctor()
}

class ConsulDoctorViewModel {
    var delegate: ConsulDoctorProtocol?
    var service = DoctorService()
    var doctorList = [DoctorResource]()
    
    func getDoctorList() {
        Network.requestNoBody(req: service) {[weak self](result) in
            switch result {
                
            case .success(let data):
                self?.doctorList = data.data ?? []
                self?.delegate?.onSuccessDoctor()
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
}
