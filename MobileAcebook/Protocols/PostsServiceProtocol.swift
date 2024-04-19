//
//  PostsServiceProtocol.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 17/04/2024.
//

import Foundation

public protocol PostsServiceProtocol {
    func getAllPostsAsync() async throws -> [Post]
    
    func createPostAsync(message: String) async throws -> Bool
}
