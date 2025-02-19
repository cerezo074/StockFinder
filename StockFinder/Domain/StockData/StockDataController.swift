//
//  StockDataController.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

protocol StockDataInterface {
    func getAllStocks() async -> [StockEntity]
    func searchStock(by query: String) async -> [StockEntity]
    func loadContent() async throws
}

actor StockDataController: StockDataInterface {
    
    private let repository: StockRepositoryInteface
    private var stockTickerTrie: Trie
    private var stockNameTrie: Trie
    private var stocksNameSet: Set<SearchableStockEntity>
    private var stocksTickerSet: Set<SearchableStockEntity>

    init(
        repository: StockRepositoryInteface? = nil
    ) {
        self.repository = repository ?? StockRepository(
            networkProvider: NetworkController(),
            database: (try? StockDB()) ?? EmptyStockDB()
        )
        stocksNameSet = []
        stocksTickerSet = []
        stockNameTrie = Trie(allowCaseSensitive: false)
        stockTickerTrie = Trie(allowCaseSensitive: false)
    }
    
    func searchStock(by query: String) async -> [StockEntity] {
        async let foundStockTickers = Task.detached {
            let tickerIDsArray = await self.stockTickerTrie.findWordsWithPrefix(prefix: query.lowercased())
                .map { SearchableStockEntity(id: $0, stock: nil) }
            let tickerIDSet = Set(tickerIDsArray)
            
            return await self.stocksTickerSet.intersection(tickerIDSet)
                .compactMap { $0.stock }
                .sorted { $0.name < $1.name }
        }
        
        async let foundStockNames = Task.detached {
            let nameIDsArray = await self.stockNameTrie.findWordsWithPrefix(prefix: query.lowercased())
                .map { SearchableStockEntity(id: $0, stock: nil) }
            let nameIDSet = Set(nameIDsArray)
            
            return await self.stocksNameSet.intersection(nameIDSet)
                .compactMap { $0.stock }
                .sorted { $0.name < $1.name }
        }
        
        let (stockTickers, stockNames) = await(foundStockTickers.value, foundStockNames.value)
        
        if !stockTickers.isEmpty {
            return stockTickers
        } else if !stockNames.isEmpty {
            return stockNames
        } else {
            return []
        }
    }
    
    func loadContent() async throws {
        try await repository.loadContent()
        await loadContentIntoDataStructures()
    }
    
    func getAllStocks() async -> [StockEntity] {
        return await repository.getAllStocks()
    }
    
    private func loadContentIntoDataStructures() async {
        let allStocks = await repository.getAllStocks()
        
        stocksNameSet = []
        stocksTickerSet = []
        stockNameTrie = Trie(allowCaseSensitive: false)
        stockTickerTrie = Trie(allowCaseSensitive: false)
        
        for stock in allStocks {
            stockNameTrie.insert(word: stock.name)
            stocksNameSet.insert(.init(id: stock.name.lowercased(), stock: stock))
            stockTickerTrie.insert(word: stock.ticker)
            stocksTickerSet.insert(.init(id: stock.ticker.lowercased(), stock: stock))
        }        
    }
}
