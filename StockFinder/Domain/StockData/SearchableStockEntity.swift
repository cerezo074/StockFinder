//
//  SearchableStockEntity.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

struct SearchableStockEntity: Hashable {
    let id: String
    let stock: StockEntity?
    
    static func == (lhs: SearchableStockEntity, rhs: SearchableStockEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
