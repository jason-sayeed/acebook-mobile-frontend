//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//
import SwiftUI
import Foundation

struct FeedView: View {
    let postsService: PostsService
    
    @State private var posts: [Post] = []
    
    init(postsService: PostsService) {
        self.postsService = postsService
    }
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                VStack{
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .accessibilityIdentifier("makers-logo")
                    NavigationLink(destination: NewPostView()) {
                        Text("What's on your mind?")
                    }
                    .padding()
                        ForEach(posts, id: \._id) {item in
                            Text("User: \(item.createdBy.username)").fontWeight(.semibold)
                                .multilineTextAlignment(.trailing)
                            Text(item.message)
                                .padding(10)
                            Divider()
                            Spacer()
                        }
                    }
                    
                .onAppear {
                    Task {
                        do {
                            posts = try await postsService.getAllPostsAsync()
                        } catch {
                            
                            print("Error fetching posts: \(error)")
                        }
                    }
                    
                }
            }
        }
    }
}
    
