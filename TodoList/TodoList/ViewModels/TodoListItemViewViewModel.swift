//
//  TodoListItemViewViewModel.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TodoListItemViewViewModel: ObservableObject {
    
    
    init() {}
    func toggleIsDone(item: TodoListItem) {
        var itemCopy = item
        itemCopy.setDone(state: !item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
