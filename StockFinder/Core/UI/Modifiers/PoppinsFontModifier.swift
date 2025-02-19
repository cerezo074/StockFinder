//
//  PoppinsFontModifier.swift
//  StockFinder
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import SwiftUI

struct PoppinsFontModifier: ViewModifier {
    var font: PoppinsFont
    var size: CGFloat

    func body(content: Content) -> some View {
        content.font(.custom(font.rawValue, size: size))
    }
}
