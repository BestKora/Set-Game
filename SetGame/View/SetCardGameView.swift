//
//  SetCardGameView.swift
//  Memorize
//
//  Created by Tatiana Kornilova on 19/12/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import SwiftUI

struct SetCardGameView: View {
    @StateObject var viewModel = SetCardGame ()
    @State var shouldDelay = true
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Deck: \(viewModel.cardsInDeck)")
                    .foregroundColor(Color.white).font(.headline)
                    .padding()
            }
            GameView(viewModel: viewModel, shouldDelay: $shouldDelay)
                .onAppear { deal() }
            HStack (spacing:50) {
                Button (viewModel.numberHint){viewModel.hint()}.greenRoundStyle()
                Button ("Deal+3"){ deal3()}.greenRoundStyle()
                    .disabled(viewModel.cardsInDeck == 0)
                    .foregroundColor(viewModel.cardsInDeck == 0 ? .gray : .white)

                Button ("New Game"){ newGame()}.greenRoundStyle()
            }.foregroundColor(Color.white).font(.headline)
        }.padding(2)
        .background(tableColor.edgesIgnoringSafeArea(.all) )
    }
    
    // MARK: - Drawing Constants & Helper Functions
   
    private var tableColor: Color {
        Color(UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)) }
    
    private func deal(){
    viewModel.deal()
    DispatchQueue.main.async {
        shouldDelay = false
    }
}
    private func deal3(){
            shouldDelay = true
            viewModel.deal3()
            DispatchQueue.main.async {
                shouldDelay = false
            }
    }
    private func newGame(){
        viewModel.resetGame()
        shouldDelay = true
        deal()
    }
}

struct GameView: View {
    @ObservedObject  var viewModel : SetCardGame
    @Binding var shouldDelay: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Grid (viewModel.cards) { card in
                CardView(card: card, setting: $viewModel.setting)
                    .transition(.cardTransition(size: geometry.size))
                    .animation( Animation.easeInOut(duration: 1.00)
                                          .delay(transitionDelay(card: card)))
                    .onTapGesture {viewModel.choose(card: card)}
                    .padding(2)
            }
        }
    }
    // MARK: - Drawing Constants & Helper Functions
   
    private let cardTransitionDelay: Double = 0.2
    private func transitionDelay(card: SetGame<SetCard>.Card) -> Double {
    guard shouldDelay else { return 0 }
    return Double(viewModel.cards.firstIndex(matching: card)!) * cardTransitionDelay
}
    
}

struct CardView: View {
    var card: SetGame<SetCard>.Card
    @Binding var setting: Setting
    
    var body: some View {
            if card.isSelected || !card.isMatched {
                SetCardView (card: card.content, setting: setting)
                    .background(card.isHint ? setting.colorHint : Color.white)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle( cornerRadius:  cornerRadius)
                        .stroke(highlightColor(), lineWidth: borderLineWidth)
                    )
            }
    }
    
    // MARK: - Drawing Constants & Helper Functions
    
    private let cornerRadius: CGFloat = 10.0
    private let borderLineWidth: CGFloat = 7
    
    private func highlightColor() -> Color {
         var color = Color.white.opacity(0)
        if card.isSelected {
            if card.isMatched {
                color = setting.colorsBorder[0]
            } else if card.isNotMatched {
                color = setting.colorsBorder[1]
            } else {
                color = setting.colorsBorder[2]
            }
        }
         return color
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardGameView(viewModel: SetCardGame())
    }
}









