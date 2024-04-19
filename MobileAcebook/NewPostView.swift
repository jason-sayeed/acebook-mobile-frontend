//
//  NewPostView.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 16/04/2024.
//

import SwiftUI

struct NewPostView: View {
    
    let postsService: PostsServiceProtocol
    
    @State private var post: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            let titleFont = Font.largeTitle.bold()
            Text("Make a new Post")
                .font(titleFont)
            
            Spacer()
            
            Text("What's on your mind?")
            LazyVStack(alignment: .center) {
                TextEditor(text: $post)
                    .frame(width: 350, height: 200, alignment: .center)
            }
            .shadow(radius:5)
            
            Button("Create Post") {
                Task {
                    do {
                        let success = try await postsService.createPostAsync(message: post)
                        print(success)
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Error creating post: \(error)")
                    }
                }
            }
            Spacer()
        }
    }
}

//#Preview {
//    NewPostView()
//}
