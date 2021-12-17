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
    let doctor: DoctorInHistory?
    let patient: PatientInHistory?
    let doctorSchedule: DoctorScheduleInHistory?

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
        case doctor, patient
        case doctorSchedule = "doctor_schedule"
    }
}

struct DoctorInHistory: Codable {
    let id: Int?
    let doctorName, speciality: String?
    let priceRate: Int?
    let imagePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case doctorName = "doctor_name"
        case speciality
        case priceRate = "price_rate"
        case imagePath = "image_path"
    }
}

struct PatientInHistory: Codable {
    let id: Int?
    let patientName, status, gender, birthDate: String?
    let age: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case patientName = "patient_name"
        case status, gender
        case birthDate = "birth_date"
        case age
    }
}

struct DoctorScheduleInHistory: Codable {
    let id: Int?
    let day, date, month, year: String?
    let timePractice: String?

    enum CodingKeys: String, CodingKey {
        case id, day, date, month, year
        case timePractice = "time_practice"
    }
}
