//
//  StockHomeViewModel.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation
import Combine

class StockHomeViewModel: ObservableObject {
    
    enum ContentViewState: Equatable {
        case noResults(title: String, suggestion: String)
        case loadingData
        case showDefaultList([StockDetailViewModel])
        case showSearchResults([StockDetailViewModel])
        case error(title: String, description: String)
        case retry(title: String, description: String)
    }
    
    @Published
    private(set) var contentViewState: ContentViewState
    private let errorTitle: String = "Error"
    private let tryAgainMessage = "We could not fetch the stocks, tap to try again."
    private let stockDataController: StockDataInterface
    let searchViewModel: SearchViewModel
    
    init(
        searchText: String,
        isSearching: Bool,
        searchPlaceholder: String,
        stockDataController: StockDataInterface
    ) {
        self.contentViewState = .loadingData
        self.stockDataController = stockDataController
        self.searchViewModel = .init(
            text: searchText,
            isLoading: isSearching,
            placeholder: searchPlaceholder
        )
        
        searchViewModel.searchCompletion = { [unowned self] query in
            await self.onSearchData(with: query)
        }
        
        searchViewModel.cleanCompletion = { [unowned self] in
            await self.resetResults()
        }
    }
    
    func viewDidLoad() async {
        await searchViewModel.viewDidLoad()
        await loadDefaultStocks()
    }
    
    func retryLoadContent() async {
        await setState(.loadingData)
        await loadDefaultStocks(refreshContent: true)
    }
    
    private func resetResults() async {
        await loadDefaultStocks()
    }
    
    private func loadDefaultStocks(refreshContent: Bool = false) async {
        do {
            if refreshContent {
                try await stockDataController.loadContent()
            }
            
            let allStocks = await stockDataController.getAllStocks()
            let stockViewModels = allStocks.map { StockDetailViewModel(from: $0) }
            if stockViewModels.isEmpty {
                await setState(.retry(title: errorTitle, description: tryAgainMessage))
                return
            }
            
            await setState(.showDefaultList(stockViewModels))
        } catch {
            print("Can not reload content: \(error)")
            
            await setState(.retry(title: errorTitle, description: tryAgainMessage))
        }
    }
    
    private func onSearchData(with query: String) async {
        let results = await stockDataController.searchStock(by: query)
        let stockViewModels = results.map { StockDetailViewModel(from: $0) }
        
        if !stockViewModels.isEmpty {
            await setState(.showSearchResults(stockViewModels))
            return
        }
        
        await setState(
            .noResults(
                title: errorTitle,
                suggestion: "There is not stock matching this query: \(query)"
            )
        )
    }
    
    private func setState(_ newState: ContentViewState) async {
        await MainActor.run {
            self.contentViewState = newState
        }
    }
}
