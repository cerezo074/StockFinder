//
//  SearchViewModel.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    enum ViewState {
        case waitingForInteraction
        case readyToSearch
        case searching
    }
    
    @Published
    var text: String = ""
    @Published
    private(set) var viewState: ViewState
    
    private var subscriptions = Set<AnyCancellable>()
    private var onFirstFocuse: Bool = false
    var searchCompletion: AsyncQueryClousure?
    var cleanCompletion: AsyncVoidClousure?
    let placeholder: String

    var allowClearText: Bool {
        !text.isEmpty
    }
    
    var disableSearch: Bool {
        viewState == .searching
    }

    init(
        text: String,
        isLoading: Bool,
        placeholder: String,
        searchCompletion: AsyncQueryClousure? = nil
    ) {
        self.text = text
        self.viewState = .waitingForInteraction
        self.placeholder = placeholder
        self.searchCompletion = searchCompletion
    }
    
    func viewDidLoad() async {
        $text
            .dropFirst()
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] value in
                self?.prepareLoader(for: value)
            })
            .debounce(for: .seconds(2), scheduler: DispatchQueue.global())
            .sink { [weak self] text in
                self?.onSearchData(with: text)
            }
            .store(in: &subscriptions)
    }
    
    func clearText(showLoader: Bool = true) {
        Task {
            await MainActor.run { text = "" }
            await setState(.readyToSearch)
            await cleanCompletion?()
            await setState(.waitingForInteraction)
        }
    }
    
    private func onSearchData(with query: String) {
        Task {
            guard !query.isEmpty else {
                await cleanCompletion?()
                await setState(.waitingForInteraction)
                return
            }
            await setState(.searching)
            await searchCompletion?(query)
            await setState(.waitingForInteraction)
        }
    }
    
    private func prepareLoader(for value: String) {
        Task {
            if !self.onFirstFocuse && value.isEmpty {
                self.onFirstFocuse = true
            } else {
                await setState(.readyToSearch)
            }
        }
    }
    
    private func setState(_ newState: ViewState) async {
        await MainActor.run {
            viewState = newState
        }
    }
}
