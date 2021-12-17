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
    
    func getHistory() {
        var params = ["page":"1"]
        Network.requestParameters(req: service, parameters: params) { [weak self] (result) in
            switch result {
                
            case .success(let data):
                print("data =  \(data.data)")
                self?.historyData += data.data
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
