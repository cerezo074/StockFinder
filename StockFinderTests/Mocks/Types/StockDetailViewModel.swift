//
//  StockDetailViewModel.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

@testable import StockFinder

extension StockDetailViewModel {
    static var apple: StockDetailViewModel {
        .init(id: 1, ticker: "AAPL", name: "Apple Inc.", rawPrice: 500)
    }
}
