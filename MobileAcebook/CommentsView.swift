//
//  CommentsView.swift
//  MobileAcebook
//
//  Created by Jason on 19/04/2024.
//

import SwiftUI

struct CommentsView: View {
    
    let commentService: CommentServiceProtocol
    
    @State private var comments: [Comment] = []
    @State private var comment: String = ""
    @State private var post: Post
    
    init(post: Post, commentService: CommentServiceProtocol) {
        self.post = post
        self.commentService = commentService
    }
    
    var body: some View {
        VStack {
            HStack{
                TextEditor(text: $comment)
                    .border(Color.gray)
                Button("Create Comment") {
                    Task {
                        do {
                            let success = try await commentService.createCommentAsync(postId: post._id, message: comment)
                            print(success)
                        } catch {
                            print("Error creating comments: \(error)")
                        }
                        comment = ""
                    }
                    getComments()
                }
            }
            .padding()
            ForEach(comments,id: \._id) { comment in
                Text("\(comment.createdBy.username) : \(comment.message)")
                Divider()
            }
        }
        .onAppear {
            getComments()
        }
    }
    
    private func getComments() {
        Task {
            do {
                comments = try await commentService.getCommentsByPostAsync(postId: post._id)
                print (comments)
            } catch {
                print("Error fetching comments: \(error)")
            }
        }
    }
}
