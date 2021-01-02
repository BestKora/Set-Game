//
//  SetCard.swift
//  Set
//
//  Created by Tatiana Kornilova on 12/31/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

struct SetCard: CustomStringConvertible, Matchable {
    
    let number: Variant // number - 1, 2, 3
    let color:  Variant // color  - 1, 2, 3 (например, red, green, purple)
    let shape:  Variant // symbol - 1, 2, 3 (например, diamond, squiggle, oval)
    let fill:   Variant // fill   - 1, 2, 3 (например, solid, striped, open)
   
    var description: String {return "\(number)-\(color)-\(shape)-\(fill)"}
    
    enum Variant: Int, CaseIterable, CustomStringConvertible  {
        case v1 = 1
        case v2
        case v3
        
        var description: String {return String(self.rawValue)}
    }
    
    static func match(cards: [SetCard]) -> Bool {
        guard cards.count == 3 else {return false}
        let sum = [
        cards.reduce(0, { $0 + $1.number.rawValue}),
        cards.reduce(0, { $0 + $1.color.rawValue}),
        cards.reduce(0, { $0 + $1.shape.rawValue}),
        cards.reduce(0, { $0 + $1.fill.rawValue})
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}
