//
//  TodoListViewViewModel.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation
import FirebaseFirestore

class TodoListViewViewModel: ObservableObject {
        
    @Published var showingNewItemView: Bool = false
    
    private let userId: String
    init(userId: String) {
        self.userId = userId
    }
    
    
    func delete(id: String) {
        
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(userId)
                .collection("todos")
                .document(id)
                .delete()
            
            print("deleting \(id)")
            
        
    }
}
