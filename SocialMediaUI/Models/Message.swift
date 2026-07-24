//
//  Message.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 24.07.2026.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let sender: User?
    let receiver: User?
    let content: String
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sender
        case receiver
        case content
        case createdAt
        case updatedAt
    }
}
