//
//  UserModel.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 13/12/21.
//

import Foundation

struct UserModel: Codable {
    let user: User
    let token: String
}

struct User: Codable {
    let id: Int
    let fullName, passwordDigest: String
    let email, gender, birthDate: String
    let phoneNumber: String
    let isAdmin, isActive: Bool
    let createdAt, updatedAt: String
//    let age: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case passwordDigest = "password_digest"
        case email, gender
        case birthDate = "birth_date"
        case phoneNumber = "phone_number"
        case isAdmin = "is_admin"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case age
    }
}
