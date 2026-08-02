//
//  AuthViewModel.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 26.07.2026.
//

import Foundation
import Combine

@Observable
@MainActor
class AuthViewModel: ObservableObject {
     var currentUser: User?
     var isAuthenticated: Bool = false
     var errorMessage: String?
     var isLoading: Bool = false
    
    private let tokenKey = "authToken"
    
    init () {
        checkExistingUser()
    }
    private func checkExistingUser() {
        // TODO: Replace with 'let token' when validating the token against the backend later
        if let _ = UserDefaults.standard.string(forKey: tokenKey) {
            self.isAuthenticated = true
        }
    }
    func logIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        let body = ["email": email, "password": password]
        
        do {
            let response: AuthResponse = try await APIService.shared.request(
                endpoint: "/user/login",
                method: "POST",
                body: body
            )
            UserDefaults.standard.set(response.token, forKey: tokenKey)
            self.currentUser = response.user
            self.isAuthenticated = true
            self.isLoading = false
            
        } catch  {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    func register(name: String,email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        let body = ["name": name, "email": email, "password": password]
        
        do {
            let response: AuthResponse = try await APIService.shared.request(
                endpoint: "/user/register",
                method: "POST",
                body: body
            )
            UserDefaults.standard.set(response.token, forKey: tokenKey)
            self.currentUser = response.user
            self.isAuthenticated = true
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    func logoout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        self.isAuthenticated = false
        self.currentUser = nil
    }
}
