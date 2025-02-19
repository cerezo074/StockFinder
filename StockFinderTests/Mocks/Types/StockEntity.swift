//
//  StockEntity.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

@testable import StockFinder

extension StockEntity {
    static var apple: StockEntity {
        .init(id: 1, ticker: "AAPL", name: "Apple Inc.", currentPrice: 500)
    }
    
    static var amazon: StockEntity {
        .init(id: 2, ticker: "AMZN", name: "Amazon.com Inc.", currentPrice: 1000)
    }
    
    static var microsoft: StockEntity {
        .init(id: 3, ticker: "MSFT", name: "Microsoft Corporation", currentPrice: 200)
    }
}
