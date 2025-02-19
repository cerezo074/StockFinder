//
//  AppContentView.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

struct AppContentView: View {
    
    @ObservedObject var appCoordinator: AppCoordinator
    
    var body: some View {
        if appCoordinator.appState == .home {
            NavigationStack(path: $appCoordinator.baseNavigationPath) {
                appCoordinator.makeView()
            }
        } else {
            appCoordinator.makeView()
        }
    }
}

#Preview {
    AppContentView(appCoordinator: .init())
}
