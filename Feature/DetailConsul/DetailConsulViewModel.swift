//
//  DetailConsulViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import Foundation


protocol DetailConsulProtocol {
    func onSuccessSchedules()
    func onFailureSchedules()
}

class DetailConsulViewModel {
    
    var service = SchedulesDoctorService()
    var delegate: DetailConsulProtocol?
    var scheduleList = [ScheduleDoctorResource]()
    
    func getDoctorSchedule(doctorId: String) {
        
        service.doctorId = doctorId
        print("doctorID = \(service.setParameters())")
        var param = ["page":"1"]
        Network.requestParameters(req: service, parameters: param) {[weak self] (result) in
            switch result {
                
            case .success(let data):
                print("masuk sukses view model")
                self?.scheduleList += data.data
                self?.delegate?.onSuccessSchedules()
            case .failure(let error):
                print("errorny detail consul \(error)")
                self?.delegate?.onFailureSchedules()
            }
        }
        
        
    }
    
    
}
