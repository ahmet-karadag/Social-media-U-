//
//  RegisterView.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 29.07.2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            Text("Create an account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom,8)
            
            TextField("your name", text: $name)
                .textInputAutocapitalization(.words)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
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
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button {
                Task {
                    await authViewModel.register(name: name, email: email, password: password)
                }
            } label: {
                
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                }else{
                    Text("sign up")
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
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RegisterView()
        .environment(AuthViewModel())
}
