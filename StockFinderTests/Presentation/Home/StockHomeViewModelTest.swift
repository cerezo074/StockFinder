//
//  StockHomeViewModelTest.swift
//  StockFinderTests
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

@testable import StockFinder
import Testing

struct StockHomeViewModelTest {
    private typealias ViewState = StockHomeViewModel.ContentViewState
    private let dataController: MockStockDataController = .init()
    private let retryState: ViewState = .retry(
        title: "Error",
        description: "We could not fetch the stocks, tap to try again."
    )
    private let noResultsState: ViewState = .noResults(
        title: "Error",
        suggestion: "There is not stock matching this query: a query"
    )
    private lazy var viewModel: StockHomeViewModel = {
        .init(
            searchText: "",
            isSearching: false,
            searchPlaceholder: "",
            stockDataController: dataController
        )
    }()

    @Test("App should load data previously, and we display it later on viewDidLoad")
    mutating func viewDidLoad_withLocalData_setStateAsShowDefaultList() async {
        await viewModel.viewDidLoad()
        
        #expect(viewModel.contentViewState == .showDefaultList([.apple]))
    }
    
    @Test("In case app could not load data previously, we display a retry screen")
    mutating func viewDidLoad_withEmptyLocalData_setStateAsRetry() async {
        dataController.stocks = []
        
        await viewModel.viewDidLoad()
        
        #expect(viewModel.contentViewState == retryState)
    }
    
    @Test
    mutating func retryLoadContent_withSuccessDataFetching_setStateAsShowDefaultList() async throws {
        await viewModel.retryLoadContent()
        
        #expect(viewModel.contentViewState == .showDefaultList([.apple]))
    }
    
    @Test
    mutating func retryLoadContent_withFailedDataFetching_setStateAsRetry() async throws {
        dataController.triggerExceptionOnLoadContent = true

        await viewModel.retryLoadContent()
        
        #expect(viewModel.contentViewState == retryState)
    }
    
    @Test("We could fetch data from remote server, but it is empty")
    mutating func retryLoadContent_withEmptyData_setStateAsRetry() async throws {
        dataController.stocks = []

        await viewModel.retryLoadContent()
        
        #expect(viewModel.contentViewState == retryState)
    }
    
    @Test("When set empty search result, we display default list")
    mutating func searchViewModel_withEmptyData_setStateAsShowDefaultList() async throws {
        await viewModel.searchViewModel.cleanCompletion?()
        
        #expect(viewModel.contentViewState == .showDefaultList([.apple]))
    }
    
    @Test("")
    mutating func searchViewModel_withValidQuery_setStateAsShowSearchResults() async throws {
        await viewModel.searchViewModel.searchCompletion?("a query")
        
        #expect(viewModel.contentViewState == .showSearchResults([.apple]))
    }
    
    @Test("")
    mutating func searchViewModel_withInvalidQuery_setStateNoResults() async throws {
        dataController.stocks = []
        
        await viewModel.searchViewModel.searchCompletion?("a query")
        
        #expect(viewModel.contentViewState == noResultsState)
    }

}
