//
//  LikeResponse.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 24.07.2026.
//

import Foundation

struct LikeResponse: Codable {
    let success: Bool
    let message: String
    let likes: Int
}
