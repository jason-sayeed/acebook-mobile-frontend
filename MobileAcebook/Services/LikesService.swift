//
//  LikesService.swift
//  MobileAcebook
//
//  Created by Aakash Rana on 18/04/2024.
//

import Foundation

class LikesService: LikesServiceProtocol {
    func updateLikesAsync(postId: String) async throws -> Bool {
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/posts") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonReq = ["postId": postId]
        let jsonBody = try? JSONSerialization.data(withJSONObject: jsonReq)
        request.httpBody = jsonBody
        let token = UserDefaults.standard.string(forKey: "jwttoken") ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let likesResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let message = likesResponse["message"] as? String
        else {
            // Throw an error if data parsing fails.
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        print(message)
        if let token = likesResponse["token"] as? String, httpResponse.statusCode == 201 {
            UserDefaults.standard.setValue(token, forKey: "jwttoken")
            return true
        } else {
            return false
        }
    }
}
