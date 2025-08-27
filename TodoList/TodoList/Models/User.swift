//
//  UserModel.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import Foundation


struct UserModel: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
 
