//
//  MockStockRepository.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

@testable import StockFinder
import Foundation

final class MockStockRepository: StockRepositoryInteface {
    
    var triggerExceptionOnLoadContent: Bool = false
    
    func getAllStocks() async -> [StockEntity] {
        [.apple, .amazon, .microsoft]
    }
    
    func loadContent() async throws {
        if triggerExceptionOnLoadContent {
            throw Errors.noInternet
        }
    }
    
}
