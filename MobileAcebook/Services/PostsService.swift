//
//  PostsService.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 17/04/2024.
//

import Foundation

class PostsService: PostsServiceProtocol {
    
    func getAllPosts() async throws -> [[AnyHashable: Any]] {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjYxZDQ1YWY5ZDBkYTQ3OWNmODRmYjIxIiwiaWF0IjoxNzEzMzY2NTg5LCJleHAiOjE3MTMzNjcxODl9.fF-kBI_t4sxQkts9djHl6sCDhTuQN7jjmS36T3NqZS4"
        
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/posts") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
//        print(urlString)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer\(token)", forHTTPHeaderField: "Authorization")
//        print(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        print(data)
        print(response)
        
        guard let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable: Any]] else {
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
//        print(JSONSerialization.jsonObject)
//        print(jsonArray)
        
        var posts: [String] = []
        
        for jsonItem in jsonArray {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonItem, options: []),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                posts.append(jsonString)
            } else {
                print("Error converting JSON item to string")
            }
        }
        return jsonArray
        
        
    }
}

        


