//
//  PostsService.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 17/04/2024.
//

import Foundation

class PostsService: PostsServiceProtocol {
    
    func getAllPostsAsync() async throws -> [Post] {
        var token: String
        if let jwtToken = UserDefaults.standard.string(forKey: "jwttoken") {
            token = jwtToken
        } else {
            token = ""
        }
        
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/posts") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let allPosts = try JSONDecoder().decode(PostsResponse.self, from: data)
        guard let postsResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let token = postsResponse["token"] as? String
        else {
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        if httpResponse.statusCode == 200 {
            UserDefaults.standard.setValue(token, forKey: "jwttoken")
            return allPosts.posts
        } else {
            return []
        }
    }
    
    func createPostAsync(message: String) async throws -> Bool {
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/posts") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonReq = ["message": message]
        let jsonBody = try? JSONSerialization.data(withJSONObject: jsonReq)
        request.httpBody = jsonBody
        
        let token = UserDefaults.standard.string(forKey: "jwttoken") ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let postResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let message = postResponse["message"] as? String
        else {
            // Throw an error if data parsing fails.
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        print(message)
        if let token = postResponse["token"] as? String, httpResponse.statusCode == 201 {
            UserDefaults.standard.setValue(token, forKey: "jwttoken")
            return true
        } else {
            return false
        }
    }
}
