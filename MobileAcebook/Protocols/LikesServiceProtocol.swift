//
//  LikesServiceProtocol.swift
//  MobileAcebook
//
//  Created by Aakash Rana on 18/04/2024.
//

import Foundation

public protocol LikesServiceProtocol {
    func updateLikesAsync(postId: String) async throws -> Bool
}
