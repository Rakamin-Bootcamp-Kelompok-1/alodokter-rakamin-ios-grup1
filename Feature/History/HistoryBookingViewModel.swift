//
//  HistoryBookingViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 10/12/21.
//

import Foundation


protocol HistoryBookingProtocol {
    func onSuccessHistory()
    func onFailureHistory()
}

class HistoryBookingViewModel {
    
    var delegate: HistoryBookingProtocol?
    var service = HistoryBookingService()
    var historyData = [HistoryBookingResource]()
    var meta = MetaModel(page: "1", nextPage: 0, totalPage: 1)
    let userDefaults = UserDefaults()
    func getHistory(page: String) {
        var params = ["page":"\(page)"]
        service.userId = "\(userDefaults.value(forKey: "id") ?? "")"
        Network.requestParameters(req: service, parameters: params) { [weak self] (result) in
            switch result {
                
            case .success(let data):
                print("data =  \(data.data)")
                self?.historyData += data.data
                self?.meta = data.meta!
                self?.delegate?.onSuccessHistory()
            case .failure(let error):
                print("errorny = \(error)")
                self?.delegate?.onFailureHistory()
            }
        }
//        Network.request(req: service) {[weak self] (result) in
//            switch result{
//            case .success(let result):
//                self?.historyData = result.data
//                self?.delegate?.onSuccessHistory()
//            case .failure(let error):
//                print("errornya = \(error)")
//                self?.delegate?.onFailureHistory()
//            }
//        }
    }
    
    
}
