//
//  TodoListView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI
import FirebaseFirestore


struct TodoListView: View {
    
    @StateObject var todolistViewModel: TodoListViewViewModel
    @FirestoreQuery var items: [TodoListItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        
        self._todolistViewModel = StateObject(wrappedValue: TodoListViewViewModel(userId: userId))
    }
    
    var body: some View {   
        NavigationStack {
            VStack {
                List(items) { item in
                    TodoListItemView(item: item).swipeActions {
                        Button("Delete") {
                            todolistViewModel.delete(id: item.id)
                        }.tint(Color.red)
                    }
                    
                }.listStyle(PlainListStyle())
            }
            .navigationTitle("Todo List")
            .toolbar {
                Button {
                    todolistViewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $todolistViewModel.showingNewItemView){
                NewItemView(newItemPresented: $todolistViewModel.showingNewItemView )
            }
            
                
        }
    }
}

#Preview {
    TodoListView(userId: "")
}
