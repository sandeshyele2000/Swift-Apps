//
//  NewItemViewViewModel.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    
    func save() {
        guard canSave else {
            return
        }
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        // prepare data
        
        let newItem = TodoListItem(
            id: UUID().uuidString,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )
        
        // store in db
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newItem.id)
            .setData(newItem.asDictionary())
    }
     
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
        
    }
}
