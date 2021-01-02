//
//  SetCardDeck.swift
//  Set
//
//  Created by Tatiana Kornilova on 12/31/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

struct SetCardDeck {
    
    private(set) var cards = [SetCard]()
    
    init() {
        for number in SetCard.Variant.allCases {
            for color in SetCard.Variant.allCases {
                for shape in SetCard.Variant.allCases {
                    for fill in SetCard.Variant.allCases {
                        cards.append(SetCard(number: number,
                                              color: color,
                                              shape: shape,
                                               fill: fill))
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    mutating func draw() -> SetCard? {
        cards.count > 0
            ? cards.remove(at: Int.random(in: 0..<cards.count))
            : nil
    }
}


