//
//  LoginView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//

import SwiftUI

struct LoginView: View {
    let authenticationService: AuthenticationService
    @State var email = ""
    @State var password = ""
    @State var failureAlert = false
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Acebook!")
                .font(.largeTitle)
                .padding(.bottom, 20)
                .accessibilityIdentifier("welcomeText")
            Spacer()
            Image("makers-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .accessibilityIdentifier("makers-logo")
            Spacer()
            Form{
                TextField("Email", text: $email)
                    .multilineTextAlignment(.center)
                SecureField("Password", text: $password)
                    .multilineTextAlignment(.center)
                Button("Log In") {
                    Task {
                        do {
                            let authenticated = try await authenticationService.loginAsync(email: email, password: password)
                            if authenticated {
                                print("Login Successful")
                            } else {
                                failureAlert = true
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .accessibilityIdentifier("loginButton")
                .alert(isPresented: $failureAlert) {
                    Alert(
                        title: Text("Login Failed"),
                        message: Text("Please try again"))
                }
            }
        }
        Spacer()
    }
}
