//
//  Post.swift
//  MobileAcebook
//
//  Created by Aakash Rana on 16/04/2024.
//

public struct Post: Codable {
    let _id: String
    let message: String
    let likes: [String]
    let createdBy: User
}

public struct PostsResponse: Codable{
    let posts: [Post]
}
