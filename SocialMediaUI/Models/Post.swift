//
//  Post.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 23.07.2026.
//

import Foundation

struct Pagination: Codable {
    let totalPosts: Int?
    let totalComments: Int?
    let totalPages: Int?
    let currentPage: Int?
    let limit: Int?
}

struct Post: Codable,Identifiable {
    let id: String
    let title: String
    let content: String
    let author: User?//we use User because .populate in backend.
    var likesCount: Int//
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case content
        case author
        case likesCount
        case createdAt
    }
}

struct PostListResponse: Codable {
    let success: Bool
    let data: [Post]
    let pagination: Pagination
}
