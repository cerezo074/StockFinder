//
//  StockDetailView.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation
import SwiftUI

struct StockDetailView: View {
    let viewModel: StockDetailViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            VStack(alignment: .leading) {
                Text(viewModel.ticker)
                    .customFont(.bold, size: 30)
                    .foregroundStyle(.darkGray)
                Text(viewModel.name)
                    .customFont(.medium, size: 15)
                    .foregroundStyle(.silverSand)
            }
            Spacer()
            Text(viewModel.price).customFont(.bold, size: 20)
                .padding(.top, 8)
                .foregroundStyle(.slateGray)
        }
    }
}

#Preview {
    StockDetailView(
        viewModel: .init(
            id: 1,
            ticker: "FLUR",
            name: "Crest Solutions",
            rawPrice: 856.61
        )
    )
}
