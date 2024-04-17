//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User) -> Bool {
        // Logic to call the backend API for signing up
        return true // placeholder
    }
    
    func loginAsync(email: String, password: String) async throws -> Bool {
        // Construct the URL for the API.
        let urlString = "http://localhost:3000/tokens"
        guard let url = URL(string: urlString) else {
            // Throw an error if the URL is invalid.
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonReq = ["email": email, "password": password]
        let jsonBody = try? JSONSerialization.data(withJSONObject: jsonReq)
        request.httpBody = jsonBody
        // Fetch the data using URLSession's async method.
        // 'await' means the function will wait for the data to be fetched.
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Parse the fetched data to a String.
        guard let loginResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let message = loginResponse["message"] as? String
        else {
            // Throw an error if data parsing fails.
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        
        print(message)
        if let token = loginResponse["token"] as? String, httpResponse.statusCode == 201 {
            UserDefaults.standard.setValue(token, forKey: "jwttoken")
            return true
        } else {
            return false
        }
    }
}
