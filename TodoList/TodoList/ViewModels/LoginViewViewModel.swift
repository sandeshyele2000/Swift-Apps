//
//  LoginViewViewModel.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation
import FirebaseAuth


class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    
    init() {
         
    }
    
    func login() {
        guard validate() else {
            return
        }
        print(email)
        print(password)
        Auth.auth().signIn(withEmail: email, password: password)
         
    }
     
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
        !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in the required details."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        return true
    }
}
