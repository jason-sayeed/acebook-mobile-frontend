//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    func signUpAsync(email: String, username: String, password: String) async throws -> Bool {
        guard let urlString = ProcessInfo.processInfo.environment["BACKEND_URL"],
              let url = URL(string: urlString + "/users") else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonReq = ["username": username, "password": password, "email": email]
        let jsonBody = try? JSONSerialization.data(withJSONObject: jsonReq)
        request.httpBody = jsonBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Parse the fetched data to a String.
        guard let signUpResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let message = signUpResponse["message"] as? String
        else {
            // Throw an error if data parsing fails.
            throw NSError(domain: "Invalid data", code: 500, userInfo: nil)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 500, userInfo: nil)
        }
        if httpResponse.statusCode != 201 {
            return false
        }
        print(message)
        return true
    }
    
    func login(user: User) -> Bool {
        // Logic to call backend API for logging in
        return true // placeholder
    }
}
