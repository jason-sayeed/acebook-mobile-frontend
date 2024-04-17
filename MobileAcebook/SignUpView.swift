//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by Jason on 16/04/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email = ""
    @State var username = ""
    @State var password = ""
    
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
            }
            .accessibilityIdentifier("signUpButton")
            
            //Spacer()
            
        }
    }
}
