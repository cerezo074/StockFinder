//
//  AppCoordinator.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    
    enum AppState {
        case onStartup
        case home
    }
    
    @Published
    var baseNavigationPath: NavigationPath
    @Published
    private(set) var appState: AppState
    private let stockDataController: StockDataInterface
    
    init(stockDataController: StockDataInterface? = nil) {
        self.baseNavigationPath = .init()
        self.appState = .onStartup
        self.stockDataController = stockDataController ?? StockDataController()
    }
    
    @ViewBuilder
    func makeView() -> some View {
        switch appState {
        case .onStartup:
            SplashScreenView(stockDataController: stockDataController) { [weak self] in
                self?.finishedStartup()
            }
        case .home:
            StockHomeView(stockDataController: stockDataController)
        }
    }
    
    private func finishedStartup() {
        appState = .home
    }
}
