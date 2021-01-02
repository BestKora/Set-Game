//
//  SetCardView.swift
//  SetGame
//
//  Created by Tatiana Kornilova on 12/12/2020.
//

import SwiftUI

struct SetCardView: View {
    var card: SetCard
    var setting : Setting
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                Spacer()
                ForEach(0..<card.number.rawValue) { index in
                   cardShape().frame(height: geo.size.height/4)
                }
                Spacer()
            }
       }.padding()
        .foregroundColor(setting.colorsShapes[card.color.rawValue - 1])
        .aspectRatio(CGFloat(6.0/8.0), contentMode: .fit)
    }
    
    @ViewBuilder private func cardShape() -> some View {
        switch shapeInSet(card:card) {
        case .diamond:  shapeFill(shape: Diamond())
        case .oval:     shapeFill(shape: Capsule())
        case .squiggle: shapeFill(shape: Squiggle())
        case .rainDrop: shapeFill(shape: RainDrop())
        }
    }
    
    @ViewBuilder private func shapeFill<setShape>(shape: setShape)-> some View
                                                where setShape: Shape {
        switch fillInSet(card:card) {
        case .stroke: shape.stroke(lineWidth: shapeLineWidth)
        case .fill:   shape.fillAndBorder()
        case .stripe: shape.stripe()
        case .blur:   shape.blur()
        }
    }
    // MARK: - Drawing Constants
    private let shapeLineWidth: CGFloat = 3
    
    private func fillInSet(card:SetCard) -> FillInSet {
        setting.fillShapes[card.fill.rawValue - 1]
    }
    private func shapeInSet(card:SetCard) ->ShapesInSet {
        setting.shapes[card.shape.rawValue - 1]
    }
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardView( card: SetCard (number:.v3, color: .v3, shape: .v3, fill: .v3), setting: Setting())
           .overlay(
                RoundedRectangle( cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
                )
        .padding()
    }
}

