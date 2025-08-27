//
//  TodoListItemView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct TodoListItemView: View {
    
    @StateObject var todoListItemViewModel = TodoListItemViewViewModel()
    var item: TodoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title).bold()
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            Button {
                todoListItemViewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
            }.buttonStyle(BorderlessButtonStyle())

        }
    }
}

#Preview {
    TodoListItemView(
        item: TodoListItem(
            id: "123",
            title: "Title",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        ))
}
