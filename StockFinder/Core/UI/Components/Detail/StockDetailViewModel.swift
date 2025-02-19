//
//  StockDetailViewModel.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

struct StockDetailViewModel: Identifiable, Equatable {
    
    let id: Int
    let ticker: String
    let name: String
    private let rawPrice: Double
    
    var price: String {
        "$\(String(format: "%.2f", rawPrice))"
    }
    
    init(
        id: Int,
        ticker: String,
        name: String,
        rawPrice: Double
    ) {
        self.id = id
        self.ticker = ticker
        self.name = name
        self.rawPrice = rawPrice
    }
    
    init(from stock: StockEntity) {
        self.id = stock.id
        self.ticker = stock.ticker
        self.name = stock.name
        self.rawPrice = stock.currentPrice
    }
}
