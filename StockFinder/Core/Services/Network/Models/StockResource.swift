//
//  StockResource.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

struct StockResource: Decodable {
    let ticker: String
    let name: String
    let currentPrice: Double
    
    init(ticker: String, name: String, currentPrice: Double) {
        self.ticker = ticker
        self.name = name
        self.currentPrice = currentPrice
    }
}
