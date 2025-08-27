//
//  NewItemVIew.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var newItemViewModel = NewItemViewViewModel()
    // Binding helps in linking parent state to be controlled by this child
    // changes will be reflected in the parent component
    
    @Binding var newItemPresented: Bool
    
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 20))
                .bold()
                .padding(.top, 100)
            
            Form {
                TextField("Enter Item", text: $newItemViewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                
                DatePicker("Due Date", selection: $newItemViewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                
                TLButton(
                     title: "Save",
                     backgroundColor: .pink,
                     foregroundColor: .white,
                     action: {
                         
                         if newItemViewModel.canSave {
                             newItemViewModel.save()
                             newItemPresented = false
                         } else {
                             newItemViewModel.showAlert = true
                         }
                        
                     }
                ).padding()
                    
                
            }.alert(isPresented: $newItemViewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill the fields correctly and select the date which is today or newer"))
            }
        }
    }
}

#Preview {
    NewItemView(
        newItemPresented: Binding(get: {
            return false
        }, set: { _ in })
    )
}

