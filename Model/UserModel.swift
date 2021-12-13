//
//  UserModel.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: Int?
    var fullname: String?
    var password: String?
    var age: Int?
    var email: String?
    var gender: String?
    var birthDate: Date?
    var phoneNumber: String?
    var imagePath: String?
    var isAdmin: Bool?
    var isActive: Bool?
    var createdAt: Date?
    var updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullname = "full_name"
        case password = "password_digest"
        case age
        case email
        case gender
        case birthDate = "birth_date"
        case phoneNumber = "phone_number"
        case imagePath = "image_path"
        case isAdmin = "is_admin"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        birthDate = try values.decodeIfPresent(Date.self, forKey: .birthDate)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        createdAt = try values.decodeIfPresent(Date.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
}
