//
//  HistoryBookingModel.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import Foundation


struct HistoryBookingModel: Codable {
    
    let data: [HistoryBookingResource]
    let meta: MetaModel?
    
}

struct HistoryBookingResource: Codable {
    let id: Int?
    let message, paymentMethod: String?
    let totalPrice, doctorID, patientID, doctorScheduleID: Int?
    let createdAt, updatedAt: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, message
        case paymentMethod = "payment_method"
        case totalPrice = "total_price"
        case doctorID = "doctor_id"
        case patientID = "patient_id"
        case doctorScheduleID = "doctor_schedule_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userID = "user_id"
        }
}
