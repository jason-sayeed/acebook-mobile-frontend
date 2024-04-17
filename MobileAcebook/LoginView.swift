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
                Form {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .multilineTextAlignment(.leading)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        PasswordFieldView("Password", text: $password)
                            .multilineTextAlignment(.leading)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
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
        .navigationBarBackButtonHidden(true)
    }
}
