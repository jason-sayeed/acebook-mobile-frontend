//
//  PostsService.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 17/04/2024.
//

import Foundation

class PostsService: PostsServiceProtocol {
    
    func getAllPosts() async throws -> [String] {
        guard let urlString = ProcessInfo.processInfo.environment["backend_url"],
              let url = URL(string: urlString + "/posts") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        guard let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        
        var posts: [String] = []
        
        for jsonItem in jsonArray {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonItem, options: []),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                posts.append(jsonString)
            } else {
                print("Error converting JSON item to string")
            }
        }
        return posts
        
        
    }
}

        


