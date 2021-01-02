//
//  ExtensionsSwiftUI.swift
//  SetMemorize
//
//  Created by Tatiana Kornilova on 26/12/2020.
//

import SwiftUI

public extension AnyTransition {

    static func cardTransition(size: CGSize) -> AnyTransition {
        let insertion = AnyTransition.offset(flyFrom (for: size))
        let removal = AnyTransition.offset(flyTo (for: size))
            .combined(with: AnyTransition.scale(scale: 0.5))
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static func flyFrom(for size:CGSize) -> CGSize {
        CGSize(width: 0.0/*CGFloat.random(in: -size.width/2...size.width/2)*/,
               height: 2 * size.height)
    }
    static func flyTo(for size:CGSize) -> CGSize {
        CGSize(width:  CGFloat.random(in: -3*size.width...3*size.width),
               height: CGFloat.random(in: -2*size.height...(-size.height)))
    }
}

public struct AnyShape: Shape {
    private var base: (CGRect) -> Path
    
    public init<S: Shape>(shape: S) {
        base = shape.path(in:)
    }
    
    public func path(in rect: CGRect) -> Path {
        base(rect)
    }
}

