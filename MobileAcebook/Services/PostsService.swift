//
//  PostsService.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 17/04/2024.
//

import Foundation

class PostsService: PostsServiceProtocol {
    
    func getAllPosts() async throws -> [[AnyHashable: Any]] {
        var token: String
        if let jwtToken = UserDefaults.standard.string(forKey: "jwttoken") {
            token = jwtToken
            print("Token: \(token)")
        } else {
            print("Token is nil")
            token = ""
        }
        
        print(token)
        
        
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/posts") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        //        print(data)
        
        if let dataString = String(data: data, encoding: .utf8) {
            print("Raw Data: \(dataString)")
        } else {
            print("Failed to decode raw data as UTF-8 string")
        }
        
        
            // Parse the JSON data into a Foundation object
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
//            let jsonString = String(data: jsonData, encoding: .utf8)
            if let jsonArray = jsonObject as? [[String: Any]] {
                // You can iterate over its elements
                print("JSON Array: \(jsonArray)")
                return jsonArray
            }
            
        
        return [[AnyHashable: Any]]
    }
}


//catch {
//            // Handle JSON parsing errors
//            throw NSError(domain: "JSON Parsing Error", code: 500, userInfo: nil)
//        }
//        do {
//            guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable: Any]] else {
//                throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
//            }
//            print(jsonArray)
//            return jsonArray

//        var posts: [String] = []
//
//            for jsonItem in jsonArray {
//            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonItem, options: []),
//               let jsonString = String(data: jsonData, encoding: .utf8) {
//                posts.append(jsonString)
//            } else {
//                print("Error converting JSON item to string")
//            }
//        }
