//
//  UserModel.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

struct UserModel: Codable {
    let user: User?
    let token: String?
    
//    enum CodingKeys: String, CodingKey {
//        case user, token
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//        token = try values.decodeIfPresent(String.self, forKey: .token)
//    }
}

struct User: Identifiable, Codable {
    let id: Int?
    let fullName, passwordDigest: String?
    let age: Int?
    let email: String?
    let gender, birthDate, phoneNumber, imageData: String?
    let isAdmin, isActive: Bool?
    let createdAt, updatedAt: String?
    let resetPasswordToken, resetPasswordSentAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case passwordDigest = "password_digest"
        case age, email, gender
        case birthDate = "birth_date"
        case phoneNumber = "phone_number"
        case imageData = "image_data"
        case isAdmin = "is_admin"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case resetPasswordToken = "reset_password_token"
        case resetPasswordSentAt = "reset_password_sent_at"
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
//        password = try values.decodeIfPresent(String.self, forKey: .password)
//        age = try values.decodeIfPresent(Int.self, forKey: .age)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        gender = try values.decodeIfPresent(String.self, forKey: .gender)
//        birthDate = try values.decodeIfPresent(String.self, forKey: .birthDate)
//        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
//        imageData = try values.decodeIfPresent(String.self, forKey: .imageData)
//        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
//        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        resetPasswordToken = try values.decodeIfPresent(String.self, forKey: .resetPasswordToken)
//        resetPasswordSentAt = try values.decodeIfPresent(Date.self, forKey: .resetPasswordSentAt)
//    }
}
