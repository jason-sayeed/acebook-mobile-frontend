//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by Jason on 16/04/2024.
//

import SwiftUI

enum ActiveAlert {
    case success, failure
}

struct SignUpView: View {
    
    let authenticationService: AuthenticationServiceProtocol
    let postsService: PostsServiceProtocol
    let commentsService: CommentsServiceProtocol
    let likesService: LikesServiceProtocol
    @State var email = ""
    @State var username = ""
    @State var password = ""
    @State var showAlert = false
    @State private var activeAlert: ActiveAlert = .failure
    
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
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        TextField("Username", text: $username)
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
                    Button("Sign Up") {
                        Task {
                            do {
                                let success = try await authenticationService.signUpAsync(email: email, username: username, password: password)
                                if success {
                                    self.activeAlert = .success
                                } else {
                                    self.activeAlert = .failure
                                }
                                self.showAlert = true
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .disabled(email.isEmpty || username.isEmpty || password.isEmpty)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("signUpButton")
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .success:
                            return Alert(title: Text("User Successfully Created"), message: Text("Please log in"))
                        case .failure:
                            return Alert(title: Text("Unable to create user"), message: Text("Please try again"))
                        }
                    }
                    
                }
                HStack {
                    Text("Already have an account?")
                    NavigationLink(destination: LoginView(authenticationService: authenticationService, postsService: postsService, commentsService: commentsService, likesService: likesService)) {
                        Text("Log in")
                    }
                }
                Spacer()
            }
            .accessibilityIdentifier("signUpButton")
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
