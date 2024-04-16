//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by Jason on 16/04/2024.
//

import SwiftUI

struct SignUpView: View {
    
    let authenticationService: AuthenticationService
    
    @State var email = ""
    @State var username = ""
    @State var password = ""
    @State var successAlert = false
    @State var failureAlert = false
    
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    var body: some View {
        NavigationView {
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
                
                TextField("Email:", text: $email)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                TextField("Username:", text: $username)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                TextField("Password:", text: $password)
                    .multilineTextAlignment(.center)
                Spacer()
                Button("Sign Up") {
                    Task {
                        do {
                            let success = try await authenticationService.signUpAsync(email: email, username: username, password: password)
                            if success {
                                successAlert = true
                            } else {
                                failureAlert = true
                            }
                        }
                        
                        catch {
                            print(error)
                        }
                    }

                }
                .alert(isPresented: $successAlert) {
                    Alert(
                        title: Text("User Successfully Created"),
                        message: Text("Please log in"))
                }
                .alert(isPresented: $failureAlert) {
                    Alert(
                        title: Text("Unable to create User"),
                        message: Text("Please try again"))
                }
                NavigationLink(destination: LoginView()) {
                Text("Log in")
                }
            }
            
            .accessibilityIdentifier("signUpButton")
            

            Spacer()
        }
        
    }
}
    
    
    
