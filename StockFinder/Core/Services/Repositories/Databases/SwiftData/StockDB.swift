//
//  StockDB.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftData

final class StockDB: SwiftDatabase {
    
    typealias T = StockEntity
    
    let container: ModelContainer
    
    /// Use an in-memory store to store non-persistent data when unit testing
    ///
    init(useInMemoryStore: Bool = false) throws {
        let configuration = ModelConfiguration(for: StockEntity.self, isStoredInMemoryOnly: useInMemoryStore)
        print("SQLite Database location: \(configuration.url)")
        container = try ModelContainer(for: StockEntity.self, configurations: configuration)
    }
}
