//
//  RainDrop.swift
//  SetMemorize
//
//  Created by Tatiana Kornilova on 15/12/2020.
//

import Foundation

import SwiftUI

struct RainDrop: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()

        path.move(to: CGPoint(x: rect.size.width/2, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width/2, y: rect.size.height), control: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addQuadCurve(to: CGPoint(x: rect.size.width/2, y: 0), control: CGPoint(x: 0, y: rect.size.height))

            return path
        }
}

struct RainDrop_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            RainDrop().stroke()
            RainDrop().stripe()
            RainDrop().fill()
        }
    }
}
