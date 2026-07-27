//
//  LoginView.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 27.07.2026.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AuthViewModel.self) private var authViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack(spacing: 20){
            
            TextField("your email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("your password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button {
                Task {
                    await authViewModel.logIn(email: email, password: password)
                }
            } label: {
                
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                }else{
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }
            .background(Color(.systemBlue))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(authViewModel.isLoading)
            .padding(.top,10)

        }
        .padding()
    }
}

#Preview {
    LoginView()
}
