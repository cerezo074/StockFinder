//
//  Errors.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

import Foundation

enum Errors: Error, LocalizedError {
    case noInternet
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection, data can't be loaded at this time."
        }
    }
}
