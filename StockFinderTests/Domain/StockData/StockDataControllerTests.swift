//
//  StockDataControllerTests.swift
//  StockFinderTests
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

@testable import StockFinder
import Foundation
import Testing

struct StockDataControllerTests {
    
    private let mockRepository: MockStockRepository = .init()
    
    private lazy var dataController: StockDataController = {
        StockDataController(repository: mockRepository)
    }()
    
    @Test
    mutating func loadContent_withNoError_finishExcecution() async throws {
         try await dataController.loadContent()
    }
    
    @Test
    mutating func loadContent_withException_doesNotfinishExcecution() async throws {
        mockRepository.triggerExceptionOnLoadContent = true
        
        await #expect(throws: Errors.self) {
            try await dataController.loadContent()
        }
    }
    
    @Test
    mutating func getAllStocks() async {
        let results = await dataController.getAllStocks()
        
        #expect(results == [.apple, .amazon, .microsoft])
    }
    
    @Test
    mutating func searchStock_whenQueryIsValidByTicker_returnsAllMatches() async throws {
        try await dataController.loadContent()
        
        let results = await dataController.searchStock(by: "a")
        #expect(results == [.amazon, .apple])
    }
    
    @Test
    mutating func searchStock_whenQueryIsValidByName_returnsAllMatches() async throws {
        try await dataController.loadContent()
        
        let results = await dataController.searchStock(by: "apple")
        #expect(results == [.apple])
    }
    
    @Test
    mutating func searchStock_whenQueryIsNotValid_returnsEmpty() async throws {
        try await dataController.loadContent()
        
        let results = await dataController.searchStock(by: "abc")
        #expect(results == [])
    }

}
