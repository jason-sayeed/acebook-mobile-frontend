//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//

import SwiftUI

struct FeedView: View {

    var fakeFeed = ["Post 1", "Post 2", "Post 3", "A very long post, to see how it behaves. Once upon a midnight dreary while I pondered weak and weary...", "Another post", "If you're a bird be an early bird to catch a worm for your breakfast plate. If you're a bird be an early bird.\nBut if you're a worm, sleep late.", "And another post, mostly because I just want the stupid thing to scroll down goddammit. Someday I'll get there I'm sure."]
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
                    List {
                        
                    }
                    ForEach(fakeFeed, id: \.self) {item in
                        Text("User goes here").fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                        Text(item)
                            .padding(10)
                        Divider()
                    }
                    Spacer()
                }
            }
        }
        
        
    }
}

#Preview {
    FeedView()
}
