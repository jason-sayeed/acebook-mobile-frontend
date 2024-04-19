//
//  LoginView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//

import SwiftUI

struct LoginView: View {
    let authenticationService: AuthenticationServiceProtocol
    let postsService: PostsServiceProtocol
    let commentsService: CommentsServiceProtocol
    @State var email = ""
    @State var password = ""
    @State var failureAlert = false
    @State var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            FeedView(postsService: postsService, commentsService: commentsService)
        } else {
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
                                    isAuthenticated = try await authenticationService.loginAsync(email: email, password: password)
                                    if isAuthenticated {
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
                    HStack {
                        Text("Don't have an account?")
                        NavigationLink(destination: SignUpView(authenticationService: authenticationService, postsService: postsService, commentsService: commentsService)) {
                            Text("Sign up")
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
