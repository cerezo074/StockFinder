//
//  StockHomeView.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

struct StockHomeView: View {
    
    @StateObject private var viewModel: StockHomeViewModel
    
    init(stockDataController: StockDataInterface) {
        self._viewModel = .init(
            wrappedValue: .init(
                searchText: "",
                isSearching: false,
                searchPlaceholder: Constants.searchPlaceholder,
                stockDataController: stockDataController
            )
        )
    }
    
    var body: some View {
        VStack {
            searchView
                .padding(.bottom, 20)
            Spacer()
            contentView
            Spacer()
        }
        .padding(.horizontal, Constants.horizontalContentPadding)
        .task {
            await viewModel.viewDidLoad()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.contentViewState {
        case .noResults(let title, let suggestion):
            showMessage(with: title, description: suggestion)
                .foregroundStyle(Constants.noResultsTextColor)
        case .error(let title, let message):
            showMessage(with: title, description: message)
                .foregroundStyle(Constants.errorTextColor)
        case .loadingData:
            loaderView
        case .showDefaultList(let defaultList):
            build(list: defaultList)
        case .showSearchResults(let searchResults):
            build(list: searchResults)
        case .retry(let title, let description):
            buildRetryButton(with: title, with: description)
        }
    }
    
    private var searchView: some View {
        SearchBarView(viewModel: viewModel.searchViewModel)
            .padding(.top, Constants.searchPaddingTop)
    }
    
    private var loaderView: some View {
        ProgressView() {
            Text("Preparing your screen...")
                .customFont(.semiBold, size: Constants.messageDescriptionFontSize)
                .multilineTextAlignment(.center)
        }
    }
    
    private func buildRetryButton(with title: String, with description: String) -> some View {
        VStack {
            showMessage(with: title, description: description)
                .foregroundStyle(Constants.errorTextColor)
                .padding(.bottom, 20)
            Button(action: {
                Task {
                    await viewModel.retryLoadContent()
                }
            }) {
                Text("Tap to retry")
                    .customFont(.regular, size: Constants.messageDescriptionFontSize)
            }
        }
    }
    
    private func build(list: [StockDetailViewModel]) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(list, id: \.id) { detailViewModel in
                    StockDetailView(viewModel: detailViewModel)
                }
            }
        }
    }
    
    private func showMessage(
        with title: String,
        description: String
    ) -> some View {
        VStack(spacing: Constants.messageSpacing) {
            Text(title)
                .customFont(.semiBold, size: Constants.messageTitleFontSize)
            Text(description)
                .customFont(.semiBold, size: Constants.messageDescriptionFontSize)
        }
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let searchPlaceholder = "Search Location"
        static let topContentSpace: CGFloat = 74
        static let horizontalContentPadding: CGFloat = 24
        static let searchPaddingTop: CGFloat = 44
        static let noResultsTextColor: Color = .darkGray
        static let errorTextColor: Color = .red
        static let messageSpacing: CGFloat = 8
        static let messageTitleFontSize: CGFloat = 30
        static let messageDescriptionFontSize: CGFloat = 15
    }
}

#Preview {
    StockHomeView(stockDataController: EmptyStockDataController())
}
