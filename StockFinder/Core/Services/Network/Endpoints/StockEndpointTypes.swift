//
//  StockEndpointTypes.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

protocol RestfulRequestGenerator {
    func makeRequest() -> URLRequest?
}

enum StockEndpointTypes: RestfulRequestGenerator {
    case list
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "gist.githubusercontent.com"
    }
    
    var headers: [String: String] {
        switch self {
        case .list:
            return ["Content-Type": "application/json"]
        }
    }
    
    var path: String {
        switch self {
        case .list:
            return "/cerezo074/b52a5ac2ef964969f51925afe70e59ca/raw/973e046b4d90537d408fa4dcf2801c3a0ea9764a/stocks-sample.json"
        }
    }
    
    var method: RestfulEndpoint.HTTPMethod {
        switch self {
        case .list:
            return .get
        }
    }

    var queryParams: [String: String]{
        switch self {
        case .list:
            return [:]
        }
    }
    
    func makeRequest() -> URLRequest? {
        RestfulEndpoint(
            scheme: scheme,
            host: host,
            path: path,
            method: method,
            queryParams: queryParams,
            headers: headers
        ).makeURLRequest()
    }
}
