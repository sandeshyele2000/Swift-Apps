//
//  LoginView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(
                    title: "To do List",
                    subtitle: "Get things done",
                    backgroundColor: Color.green,
                    angle: 15
                )
                
                if !loginViewModel.errorMessage.isEmpty {
                    Text(loginViewModel.errorMessage)
                        .foregroundColor(.red)
                }
                // Login Form
                Form {
                    TextField("Email", text: $loginViewModel.email )
                        .autocapitalization(.none)
                    SecureField("Password", text: $loginViewModel.password)
                     
                    TLButton(
                        title: "Login",
                        backgroundColor: .yellow,
                        foregroundColor: .white
                    ) {
                        loginViewModel.login()
                    }.padding()
                    
                }
                
                
                VStack {
                    Text("New around here?")
                        .font(.caption)
                    
                    NavigationLink("Create an account", destination: RegisterView())
            
                }
                
                Spacer()
                // Create New Account
            }
        }
    }
}

#Preview {
    LoginView()
}
