//
//  CommentsService.swift
//  MobileAcebook
//
//  Created by Jason on 18/04/2024.
//

import Foundation

class CommentService: CommentServiceProtocol {
    func createCommentAsync(postId: String, message: String) async throws -> Bool {
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/comments/" + postId) else {
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
        
        guard let commentResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let message = commentResponse["message"] as? String
        else {
            // Throw an error if data parsing fails.
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        print(message)
        if let token = commentResponse["token"] as? String, httpResponse.statusCode == 201 {
            UserDefaults.standard.setValue(token, forKey: "jwttoken")
            return true
        } else {
            return false
        }
    }
    
    func getCommentsByPostAsync(postId: String) async throws -> [Comment] {
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/comments/" + postId) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = UserDefaults.standard.string(forKey: "jwttoken") ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let commentResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let message = commentResponse["message"] as? String
                
        else {
            // Throw an error if data parsing fails.
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        print(message)
        if let token = commentResponse["token"] as? String, httpResponse.statusCode == 200 {
            UserDefaults.standard.setValue(token, forKey: "jwttoken")
            do {
                let commentsResponse = try JSONDecoder().decode(CommentsResponse.self, from: data)
                return commentsResponse.comments
            } catch {
                print("Decoding error: \(error)")
                return []
            }
        } else {
            return []
        }
    }
}
