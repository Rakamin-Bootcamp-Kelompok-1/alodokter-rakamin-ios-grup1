//
//  ConsulDoctorViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import UIKit

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
    var specialty: [SpecialityModel] = [
        SpecialityModel(id: 1, speciality: "Dokter Umum", image: UIImage(named:"ic_dokter_umum")!),
        SpecialityModel(id: 2, speciality: "Dokter Anak", image: UIImage(named: "ic_dokter_anak")!),
        SpecialityModel(id: 1, speciality: "Dokter Mata", image: UIImage(named: "ic_dokter_umum")!),
        SpecialityModel(id: 1, speciality: "Dokter Paru", image: UIImage(named: "ic_dokter_paru")!)
    
    ]
    
    
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
