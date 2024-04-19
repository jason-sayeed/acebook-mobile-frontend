//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//
import SwiftUI
import Foundation

struct FeedView: View {
    let postsService: PostsServiceProtocol
    let commentService: CommentServiceProtocol
    
    @State private var posts: [Post] = []
    
    init(postsService: PostsServiceProtocol, commentService: CommentServiceProtocol) {
        self.postsService = postsService
        self.commentService = commentService
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
                    NavigationLink(destination: NewPostView(postService: postsService)) {
                        Text("What's on your mind?")
                    }
                    .padding()
                    ForEach(posts, id: \._id) { post in
                        PostView(post: post, commentService: commentService)
                        }
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
