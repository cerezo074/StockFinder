//
//  SplashScreenView.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    @StateObject private var viewModel: SplashScreenViewModel
    
    init(
        stockDataController: StockDataInterface,
        didFinishLoading: @escaping VoidClousure
    ) {
        self._viewModel = .init(
            wrappedValue: .init(
                stockDataController: stockDataController,
                didFinishLoading: didFinishLoading
            )
        )
    }
    
    var body: some View {
        switch viewModel.state {
        case .loaded:
            VStack {
                logo.padding(.bottom, 20)
                Text("Data has loaded!!!")
                    .customFont(.regular, size: 20)
            }
        case .loading:
            VStack {
                logo.padding(.bottom, 20)
                ProgressView("Loading data...")
                    .customFont(.regular, size: 20)
            }.task {
                await viewModel.viewDidLoad()
            }
        }
    }
    
    private var logo: some View {
        VStack {
            Text("Stock Finder")
                .customFont(.bold, size: 50)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .foregroundStyle(.blue)
            Image(systemName: "chart.line.uptrend.xyaxis")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    SplashScreenView(stockDataController: EmptyStockDataController(), didFinishLoading: {})
}
