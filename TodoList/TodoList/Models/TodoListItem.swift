//
//  TodoListItem.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation


struct TodoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    
    mutating func setDone(state: Bool) {
        isDone = state
    }
}
