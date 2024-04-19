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
    let likesService: LikesServiceProtocol
    
    @State private var posts: [Post] = []
    
    init(postsService: PostsServiceProtocol, commentService: CommentServiceProtocol, likesService: LikesServiceProtocol) {
        self.postsService = postsService
        self.commentService = commentService
        self.likesService = likesService
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
                    ForEach(posts, id: \._id) { post in
                        PostView(post: post, commentService: commentService, likesService: likesService)
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
