//
//  DoctorModel.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import Foundation


struct DoctorModel: Codable {
    let data: [DoctorResource]?
    let meta: MetaModel?
}

struct DoctorResource: Codable {
    let id: Int?
    let doctorName, speciality, status, star: String?
    let locationPractice, biography, education: String?
    let priceRate: Int?
    let createdAt, updatedAt, imagePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case doctorName = "doctor_name"
        case speciality, status, star
        case locationPractice = "location_practice"
        case biography, education
        case priceRate = "price_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imagePath = "image_path"
    }
}
