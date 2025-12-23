//
//  temp.swift
//  Crypto
//
//  Created by Sandesh on 12/12/25.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error in loading persistent stores: \(error)")
            }
            
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        
        if let entity = savedEntities.first(where: { $0.coinID == coin.id}) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }

    }
    
    
    
    
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let err {
            print("Error fetching data: \(err)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let err {
            print("Error saving data: \(err)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
