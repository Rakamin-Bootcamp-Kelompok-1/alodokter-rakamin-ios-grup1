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
    func onSuccessSearchDoctor()
    func onFailureSearchDoctor()
}

class ConsulDoctorViewModel {
    var delegate: ConsulDoctorProtocol?
    var service = DoctorService()
    var searchService = SearchDoctorService()
    var doctorList = [DoctorResource]()
    var searchDoctorList = [DoctorResource]()
    
    func getDoctorList() {
        Network.requestNoBody(req: service) {[weak self](result) in
            switch result {
                
            case .success(let data):
                self?.doctorList += data.data ?? []
//                self?.doctorList.append(contentsOf: data.data ?? [])
                self?.delegate?.onSuccessDoctor()
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
    
    func searchDoctor(name: String) {
        searchService.doctorName = name
        Network.request(req: searchService) { [weak self] (result) in
            switch result {
                
            case .success(let data):
                self?.searchDoctorList = data.data ?? []
                self?.delegate?.onSuccessSearchDoctor()
            case .failure(let error):
                self?.delegate?.onFailureSearchDoctor()
            }
        }
    }
    
    func resetSearch() {
        self.searchDoctorList = []
        self.delegate?.onSuccessDoctor()
    }
}
