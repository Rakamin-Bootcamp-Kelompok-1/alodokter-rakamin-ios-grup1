//
//  Route.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import Foundation

enum Route {
  
    static let baseUrl = "https://medikuy.herokuapp.com"
    
    case historyBooking
    case searchDoctor
    case schedulesDoctor
    case doctorBySpeciality
    
    
    var description: String {
        switch self {
        case .historyBooking:
            return "/booking/history"
        case .searchDoctor:
            return "/doctors/search"
        case .schedulesDoctor:
            return "/schedule/doctor"
        case .doctorBySpeciality:
            return "/doctors/category"
        }
        
        }
    
}
