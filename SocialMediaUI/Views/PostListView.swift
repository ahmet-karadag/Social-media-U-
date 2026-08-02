//
//  PostListView.swift
//  SocialMediaUI
//
//  Created by ahmet karadağ on 31.07.2026.
//

import SwiftUI

struct PostListView: View {
    @State private var postViewModel = PostViewModel()
    @Environment(AuthViewModel.self) private var authViewModel
    
    
    var body: some View {
        NavigationStack{
            Group{
                if postViewModel.isloading {
                    ProgressView()
                }else if let errorMessage = postViewModel.errorMessage{
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                }else{
                    List(postViewModel.posts){post in
                        VStack(alignment: .leading,spacing: 8){
                            Text(post.title)
                                .font(.headline)
                            Text(post.content)
                                .font(.body)
                                .lineLimit(4)
                        }
                        .padding(.vertical,6)
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                if let token = UserDefaults.standard.string(forKey: "authToken"){
                    await postViewModel.fetchPosts(token: token)
                }
            }
        }
    }
}

#Preview {
    PostListView()
        .environment(AuthViewModel())
}
