//
//  View+.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

extension View {
    func customFont(_ font: PoppinsFont, size: CGFloat) -> some View {
        self.modifier(PoppinsFontModifier(font: font, size: size))
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ifLet<V, Content: View>(_ value: V?, transform: (Self, V) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}
