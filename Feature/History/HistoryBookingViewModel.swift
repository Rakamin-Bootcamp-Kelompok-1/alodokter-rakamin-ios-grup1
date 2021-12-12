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
    
    func getHistory() {
        
    }
    
    
}
