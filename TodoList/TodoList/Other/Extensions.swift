//
//  Extensions.swift
//  TodoList
//
//  Created by Sandesh on 25/08/25.
//

import Foundation




extension Encodable {
    
    
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
        
    }
    
}
