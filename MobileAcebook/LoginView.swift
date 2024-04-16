//
//  LoginView.swift
//  MobileAcebook
//
//  Created by Daniela Castilla on 16/04/2024.
//

import SwiftUI

struct LoginView: View {
    
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
            Form{
                TextField("Username", text: $username)
                    .multilineTextAlignment(.center)
                SecureField("Password", text: $password)
                    .multilineTextAlignment(.center)
                Button("Log In") {
                    // logic:
                    // add username and password to User struct
                    //if User is in the database (contact backend): redirect to feedview
                    //else tell user credentials are wrong and try again
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .accessibilityIdentifier("loginButton")
            }
                    
                }
                
            
            
            Spacer()
            
        }
    }


#Preview {
    LoginView()
}
