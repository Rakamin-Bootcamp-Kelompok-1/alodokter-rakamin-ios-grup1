//
//  HistoryBookingViewModel.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy on 10/12/21.
//

import Foundation

protocol BookingProtocol {
    func onSuccess()
    func onFailure()
}

class BookingViewModel {
    
    var delegate: BookingProtocol?
    var service = BookingService()
    var historyData = [HistoryBookingResource]()
    
    func book(body: [String: Any]) {
        Network.requestParameters(req: service, parameters: body) { [weak self] (result) in
            switch result {
                
            case .success(let data):
                self?.historyData += data.data
                self?.delegate?.onSuccess()
            case .failure(let error):
                self?.delegate?.onFailure()
            }
        }
    }
    
    
}
