//
//  SetGameApp.swift
//  SetGame
//
//  Created by Tatiana Kornilova on 19/12/2020.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetCardGameView(viewModel: SetCardGame())
        }
    }
}
