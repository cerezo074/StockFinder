//
//  MockStockDataController.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

@testable import StockFinder
import Foundation

final class MockStockDataController: StockDataInterface {
    
    var stocks: [StockEntity] = [.apple]
    var triggerExceptionOnLoadContent: Bool = false
    var triggerExceptionOnSearch: Bool = false
        
    func getAllStocks() async -> [StockEntity] {
        stocks
    }
    
    func searchStock(by query: String) async -> [StockEntity] {
        stocks
    }
    
    func loadContent() async throws {
        if triggerExceptionOnLoadContent {
            throw Errors.noInternet
        }
    }

}
