//
//  CommentServiceProtocol.swift
//  MobileAcebook
//
//  Created by Jason on 18/04/2024.
//

public protocol CommentServiceProtocol {
    func createCommentAsync(postId: String, message: String) async throws -> Bool
    
    func getCommentsByPostAsync(postId: String) async throws -> [Comment]
}
