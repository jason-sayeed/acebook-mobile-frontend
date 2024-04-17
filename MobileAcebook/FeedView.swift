//
//  FeedView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//
import SwiftUI
import Foundation

struct FeedView: View {
    
    @State private var posts: [[AnyHashable: Any]] = []
    
//    struct PostItem: Hashable {
//        var user: String
//        var content: String
//        // Add any other properties as needed
//
//        // Implementing hash(into:) method to conform to Hashable
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(user)
//            hasher.combine(content)
//            // Combine other properties if needed
//        }
//    }
    
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
//                    print(posts)
//                    Text("Example")
//                      print({posts.first.keys["_id"]})
//                    ForEach(posts, id: \.self) {item in
//                        Text("User: ").fontWeight(.semibold)
//                            .multilineTextAlignment(.trailing)
//                        Text(item)
//                            .padding(10)
//                        Divider()
////                    }
//                    Spacer()
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
 
