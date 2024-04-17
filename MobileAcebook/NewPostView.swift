//
//  NewPostView.swift
//  MobileAcebook
//
//  Created by Reeva Christie on 16/04/2024.
//

import SwiftUI

struct NewPostView: View {
    
    @State var typing = ""
    
    var body: some View {
        VStack {
            let titleFont = Font.largeTitle.bold()
            Text("NEW POST")
                .font(titleFont)
            
            Spacer()
            
            Text("What's On Your Mind?")
            LazyVStack(alignment: .center) {
                TextEditor(text: $typing)
                    .frame(width: 350, height: 200, alignment: .center)
                Text(typing).opacity(0)
            
            }
            .shadow(radius:5)
            
            Button("POST!") {
                
            }
            
            Spacer()
        }
    }
}

#Preview {
    NewPostView()
}
