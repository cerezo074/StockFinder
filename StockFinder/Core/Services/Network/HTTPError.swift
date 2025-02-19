//
//  HTTPError.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

struct HTTPError: LocalizedError {
    let statusCode: Int
    let responseBody: [String: Any]?

    var errorDescription: String? {
        if let responseBody = responseBody {
            return "HTTP Error \(statusCode): \(responseBody)"
        } else {
            return "HTTP Error \(statusCode): No response body"
        }
    }
}
