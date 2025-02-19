//
//  EmptyStockDB.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

class EmptyStockDB: Database {
    
    typealias T = StockEntity
    
    init () {
        assertionFailure("Using EmptyDatabase is not recommended as fallback for release code")
    }
    
    func create(_ item: StockEntity) throws {
        
    }
    
    func create(_ items: [StockEntity]) throws {

    }
    
    func read(
        sortBy sortDescriptors: [SortDescriptor<StockEntity>]
    ) throws -> [StockEntity] {
        return []
    }
    
    func update(_ item: StockEntity) throws {
        
    }
    
    func delete(_ item: StockEntity) throws {
        
    }
}
