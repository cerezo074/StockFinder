//
//  SplashScreenViewModel.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

class SplashScreenViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded
    }
    
    @Published
    @MainActor
    private(set) var state: ViewState = .loading
    private let didFinishLoading: VoidClousure
    private let stockDataController: StockDataInterface
    
    init(
        stockDataController: StockDataInterface,
        didFinishLoading: @escaping VoidClousure
    ) {
        self.stockDataController = stockDataController
        self.didFinishLoading = didFinishLoading
    }
    
    func viewDidLoad() async {
        do {
            try await stockDataController.loadContent()
        } catch {
            print("Error loading content: \(error)")
        }
        
        await MainActor.run { [weak self] in
            self?.state = .loaded
            self?.didFinishLoading()
        }
    }
}
