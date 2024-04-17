//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//
import SwiftUI
import Foundation

struct FeedView: View {
    
    @State private var posts: [String] = []
    
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
                    ForEach(posts, id: \.self) {item in
                        Text("User goes here").fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                        Text(item)
                            .padding(10)
                        Divider()
                    }
                    Spacer()
                }
            }
            .onAppear {
                Task {
                    do {
                        posts = try await PostsService().getAllPosts()
                    } catch {
                        
                        print("Error fetching posts: \(error)")
                    }
                }
                
            }
            
        }
    }
}
        
#Preview {
        FeedView()
        }
 
