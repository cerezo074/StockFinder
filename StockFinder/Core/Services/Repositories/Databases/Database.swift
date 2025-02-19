//
//  Database.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

// For more information, https://blog.jacobstechtavern.com/p/swiftdata-outside-swiftui

protocol Database<T> {
    associatedtype T
    func create(_ item: T) throws
    func create(_ items: [T]) throws
    func read(sortBy sortDescriptors: [SortDescriptor<T>]) throws -> [T]
    func update(_ item: T) throws
    func delete(_ item: T) throws
}

typealias StockDataBaseInterface = Database<StockEntity>
