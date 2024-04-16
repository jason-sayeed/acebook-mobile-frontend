//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    func signUpAsync(email: String, username: String, password: String) async throws -> Bool
    
    func login(user: User) -> Bool
}
