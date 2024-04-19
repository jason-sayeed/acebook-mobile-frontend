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
    
    @State private var showComments = false
    
    var body: some View {
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
        }
        .border(.black, width: 1)
        .font(.system(size: 18))
        Spacer()
        if showComments {
            CommentsView(post: post, commentsService: commentsService)
        }
        Spacer()
    }
}
