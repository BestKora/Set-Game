//
//  GreenRoundStyle.swift
//  SetGame
//
//  Created by Tatiana Kornilova on 28/12/2020.
//

import SwiftUI

struct GreenRoundButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 3))
    }
}

extension View {
    func greenRoundStyle() -> some View {
        self.modifier(GreenRoundButton())
    }
}
