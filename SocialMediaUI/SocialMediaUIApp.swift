//
//  SocialMediaUIApp.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 23.07.2026.
//

import SwiftUI

@main
struct SocialMediaUIApp: App {
    @State private var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                Text("succed login")
            }else {
                LoginView()
                    .environment(authViewModel)
            }
            
        }
    }
}
