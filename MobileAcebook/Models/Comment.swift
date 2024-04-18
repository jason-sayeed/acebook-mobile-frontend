//
//  Comment.swift
//  MobileAcebook
//
//  Created by Jason on 18/04/2024.
//


public struct Comment: Codable {
    let _id: String
    let message: String
    let createdAt: String
    let createdBy: User
}

public struct CommentsResponse: Codable {
    let comments: [Comment]
}
