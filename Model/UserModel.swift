//
//  UserModel.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let fullname: String
    let password: String
    let age: Int?
    let email: String
    let gender: String
    let birthDate: Date?
    let phoneNumber: String?
    let imagePath: String?
    let isAdmin: Bool?
    let isActive: Bool?
    let createdAt: Date?
    let updatedAt: Date?
    
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
}
