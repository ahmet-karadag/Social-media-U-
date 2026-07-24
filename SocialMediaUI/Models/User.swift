//
//  User.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 23.07.2026.
//

import Foundation

struct User :Codable, Identifiable {
    let id: String
    let username: String
    let email: String
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case email
        case createdAt
        case updatedAt
    }
}

struct AuthResponse: Codable {
    let message: String
    let user: User
    let token: String
}


