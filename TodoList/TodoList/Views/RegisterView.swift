//
//  RegisterView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerViewModel = RegisterViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Register",
                           subtitle: "Start organizing todos",
                           backgroundColor: Color.orange,
                           angle: -15)
                
                Form {
                    TextField(
                        "Enter your Name",
                        text: $registerViewModel.name
                    ).autocapitalization(.none)
                    
                    TextField(
                        "Enter your Email",
                        text: $registerViewModel.email
                    ).autocapitalization(.none)
                    
                    SecureField(
                        "Enter Password",
                        text: $registerViewModel.password
                    )
                    
                    TLButton(
                        title: "Create an account",
                        backgroundColor: .blue,
                        foregroundColor: .white
                    ) {
                        registerViewModel.register()
                    }.padding()
                }
                
                Spacer()
            }
            

        }
    }
}

#Preview {
    RegisterView()
}
