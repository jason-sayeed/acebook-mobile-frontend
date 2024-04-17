//
//  PostsServiceProtocol.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 17/04/2024.
//

import Foundation

public protocol PostsServiceProtocol {
    func getAllPosts() async throws -> [[AnyHashable: Any]]
}
