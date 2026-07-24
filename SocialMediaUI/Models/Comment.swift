//
//  Comment.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 24.07.2026.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    let author: User? // I did .populate('author') in backend
    let post: String
    let content: String
    let likes: [String]?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case author
        case post
        case content
        case likes
        case createdAt
        case updatedAt
    }
}
struct CommentListResponse : Codable {
    let success: Bool
    let data: [Comment]
    let pagination: Pagination
}
