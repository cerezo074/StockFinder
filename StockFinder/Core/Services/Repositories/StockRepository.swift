//
//  StockRepository.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

protocol StockRepositoryInteface {
    func getAllStocks() async -> [StockEntity]
    func loadContent() async throws
}

actor StockRepository: StockRepositoryInteface {
    
    private let networkProvider: NetworkServices
    private let database: any StockDataBaseInterface
    private var stocks: [StockEntity] = []
    
    init(
        networkProvider: NetworkServices,
        database: any StockDataBaseInterface
    ) {
        self.networkProvider = networkProvider
        self.database = database
    }
    
    func getAllStocks() async -> [StockEntity] {
        return stocks
    }
    
    func loadContent() async throws {
        let localStockEntities = try database.read(sortBy: [.init(\.id, order: .forward)])
        
        if !localStockEntities.isEmpty {
            stocks = localStockEntities
            return
        }
        
        let remoteStockEntities = try await fetchDataFromRemoteResource()
        
        // We don't need to wait until data is saved
        Task {
            try self.database.create(remoteStockEntities)
        }
        
        stocks = remoteStockEntities
    }
    
    private func fetchDataFromRemoteResource() async throws -> [StockEntity] {
        let endpoint = StockEndpointTypes.list
        
        guard let remoteResource = try await networkProvider.fetchData(
            of: [StockResource].self,
            with: endpoint
        ) else {
            return []
        }
        
        let stockEntities = remoteResource.enumerated().map { (index, element) in
            StockEntity(from: element, id: index)
        }
        
        return stockEntities
    }
}
