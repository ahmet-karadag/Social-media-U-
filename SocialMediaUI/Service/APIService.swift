//
//  APIService.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 25.07.2026.
//

import Foundation

enum APIError: Error,LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL adress"
        case .invalidResponse:
            return "Invalid response from the server"
        case .unauthorized:
            return "Unauthorized acces: please login again"
        case .serverError(let message):
            return message
        }
    }
}

class APIService {
    static let shared = APIService()
    
    private init(){
        
    }
    private let baseUrl = "http://localhost:3000/api"
    
    //request func
    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Encodable? = nil,
        token: String? = nil
    )async throws -> T{
        
        guard let url = URL(string: baseUrl + endpoint) else {
            throw APIError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw APIError.unauthorized
            
        default:
            if let errorResponse = try? JSONDecoder().decode([String: String].self, from: data),
               let message = errorResponse["message"] {
                throw APIError.serverError(message)
            } else {
                throw APIError.serverError("Server error code: \(httpResponse.statusCode)")
            }
            
        }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
