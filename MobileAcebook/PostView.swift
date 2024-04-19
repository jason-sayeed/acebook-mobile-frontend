//
//  PostView.swift
//  MobileAcebook
//
//  Created by Jason on 19/04/2024.
//

import SwiftUI

struct PostView: View {
    
    let commentService: CommentServiceProtocol
    
    @State private var post: Post
    @State private var showComments = false
    
    init(post: Post, commentService: CommentServiceProtocol) {
        self.post = post
        self.commentService = commentService
    }
    
    var body: some View {
        VStack{
            Text("User: \(post.createdBy.username)").fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
            Text(post.message)
                .padding(10)
            Divider()
            Button(showComments ? "Hide comments" : "Show comments") {
                showComments.toggle()
            }
        }
        .font(.footnote)
        if showComments {
            CommentsView(post: post, commentService: commentService)
        }
        Spacer()
    }
}
