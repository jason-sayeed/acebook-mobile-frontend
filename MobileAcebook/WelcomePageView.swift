//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
    
    let authenticationService = AuthenticationService()
    let commentService = CommentService()
    let likesService = LikesService()

    var body: some View {
        NavigationView {
            ZStack {
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
                    NavigationLink(destination: SignUpView(authenticationService: authenticationService, likesService: likesService, commentService: commentService)) {
                        Text("Sign Up")
                    }
                    .accessibilityIdentifier("signUpButton")
                    NavigationLink(destination: LoginView(authenticationService: authenticationService, likesService: likesService, commentService: commentService)) {
                        Text("Log In")
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
