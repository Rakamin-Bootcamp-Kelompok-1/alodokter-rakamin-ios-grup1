//
//  SchedulesDoctor.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import Foundation


struct SchedulesDoctorModel: Codable {
    let data: [ScheduleDoctorResource]
}

struct ScheduleDoctorResource: Codable {
    let id, doctorID: Int?
    let day, date, month, year: String?
    let timePractice: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case doctorID = "doctor_id"
        case day, date, month, year
        case timePractice = "time_practice"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
