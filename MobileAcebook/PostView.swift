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
    @State private var postLiked = false
    
    var body: some View {
        HStack {
            VStack{
                Text("User: \(post.createdBy.username)").fontWeight(.semibold)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 13))
                Text(post.message)
                    .padding(10)
                Divider()
                Button(showComments ? "Hide comments" : "Show comments") {
                    showComments.toggle()
                }
                Spacer()
                    .font(.footnote)
            }
            .font(.system(size: 18))
            Spacer()
            Button() {
                Task {
                    do {
                        let success = try await likesService.updateLikesAsync(postId: post._id)
                        postLiked.toggle()
                        print(success ? "Post liked/unliked" : "Failed to like/unlike post")
                    } catch {
                        print("Error updating likes \(error)")
                    }
                }
            } label: {
                if postLiked {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "hand.thumbsup")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 25, height: 25)
            Spacer()
        }
        .border(.black, width: 1)
        if showComments {
            CommentsView(post: post, commentsService: commentsService)
        }
        Spacer()
    }
}
