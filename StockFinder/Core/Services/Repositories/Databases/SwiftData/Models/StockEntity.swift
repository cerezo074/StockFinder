//
//  StockEntity.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation
import SwiftData

@Model
final class StockEntity: Hashable {
    
    @Attribute(.unique)
    private(set) var id: Int
    private(set) var ticker: String
    private(set) var name: String
    private(set) var currentPrice: Double
    
    init(id: Int, ticker: String, name: String, currentPrice: Double) {
        self.id = id
        self.ticker = ticker
        self.name = name
        self.currentPrice = currentPrice
    }
    
    init(from stock: StockResource, id: Int) {
        self.id = id
        self.ticker = stock.ticker
        self.name = stock.name
        self.currentPrice = stock.currentPrice
    }
    
    static func == (lhs: StockEntity, rhs: StockEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
