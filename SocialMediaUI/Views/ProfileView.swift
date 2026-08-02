//
//  ProfileView.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 2.08.2026.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                Spacer()
                
                Button(role: .destructive) {
                    authViewModel.logoout()
                } label: {
                    Text("Log out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .environment(AuthViewModel())
}
