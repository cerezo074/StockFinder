//
//  StockFinder.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

@main
struct StockFinder: App {
    
    @StateObject private var appCoordinator: AppCoordinator
    
    init() {
        self._appCoordinator = .init(wrappedValue: .init())
    }
    
    var body: some Scene {
        WindowGroup {
            AppContentView(appCoordinator: appCoordinator)
        }
    }
}
