//
//  PostView.swift
//  MobileAcebook
//
//  Created by Jason on 19/04/2024.
//

import SwiftUI

struct PostView: View {
        
    @State var post: Post
    let commentsService: CommentsServiceProtocol
    let likesService: LikesServiceProtocol
    
    @State private var showComments = false
    
    var body: some View {
        HStack {
            VStack{
                Text("User: \(post.createdBy.username)").fontWeight(.semibold)
                    .multilineTextAlignment(.trailing)
                Text(post.message)
                    .padding(10)
                Divider()
                Button(showComments ? "Hide comments" : "Show comments") {
                    showComments.toggle()
                }
                .font(.footnote)
            }
            Button("Like") {
                Task {
                    do {
                        let success = try await likesService.updateLikesAsync(postId: post._id)
                        print(success ? "Post liked/unliked" : "Failed to like/unlike post")
                    } catch {
                        print("Error updating likes \(error)")
                    }
                }
            }
        }
        if showComments {
            CommentsView(post: post, commentsService: commentsService)
        }
        Spacer()
    }
}
