//
//  EmptyStockDataController.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

class EmptyStockDataController: StockDataInterface {
    func getAllStocks() async -> [StockEntity] {
        return []
    }
    
    func searchStock(by query: String) async -> [StockEntity] {
        []
    }
    
    func loadContent() async {
        
    }
}
