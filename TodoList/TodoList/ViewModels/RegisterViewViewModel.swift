//
//  RegisterViewViewModel.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {
    }
    
    
    func register()  {
        guard validate() else {
            return
        }
        
        
        // weak self is used to store weak reference of this class
        // basically to remove the ref after component is unmounted -> prevents memory leak
        
        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] result, error in guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserIntoDB(id: userId)
            
        }
        
    }
    
    private func insertUserIntoDB(id: String)  {
        let newUser = UserModel(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
            
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in the required details."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        
        return true
    }
}
