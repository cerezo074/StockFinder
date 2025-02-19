//
//  SearchBarView.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        HStack {
            input
            rightIcon
                .padding(.trailing, Constants.trailingRightComponent)
        }
        .background(.whiteSmoke)
        .cornerRadius(Constants.cornerRadius)
    }
    
    private var input: some View {
        TextField(viewModel.placeholder, text: $viewModel.text)
            .foregroundStyle(.darkGray)
            .textFieldStyle(PlainTextFieldStyle())
            .customFont(.regular, size: Constants.fontSize)
            .padding(.leading, Constants.leadingInputPadding)
            .padding(.vertical, Constants.verticalInputPadding)
            .disabled(viewModel.disableSearch)
    }
    
    @ViewBuilder
    private var rightIcon: some View {
        switch viewModel.viewState {
        case .waitingForInteraction where !viewModel.allowClearText:
            Image(.search)
        case .waitingForInteraction where viewModel.allowClearText:
            Button(action: {
                viewModel.clearText()
            }) {
                Image(systemName: Constants.clearButtonImage)
                    .foregroundColor(.gray)
            }
        default:
            ProgressView()
        }
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let verticalInputPadding: CGFloat = 12
        static let leadingInputPadding: CGFloat = 20
        static let fontSize: CGFloat = 15
        static let trailingRightComponent: CGFloat = 20
        static let cornerRadius: CGFloat = 15
        static let clearButtonImage = "xmark.circle.fill"
    }
}

#Preview {
    SearchBarView(
        viewModel: .init(
            text: "",
            isLoading: false,
            placeholder: "Search Location"
        )
    )
}
