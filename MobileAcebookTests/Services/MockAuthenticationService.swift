//
//  MockAuthenticationService.swift
//  MobileAcebookTests
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

@testable import MobileAcebook

class MockAuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User) -> Bool {
        // Mocked logic for unit tests
        return true // placeholder
    }
    
    func loginAsync(email: String, password: String) async throws -> Bool {
        return true // placeholder
    }
}
