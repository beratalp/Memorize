//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alp Erbil on 28.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["🚗","🚌","🚑","🚜","🛴","🚲","🚔","🛺","🚘","🚃","🚄"
                         ,"🚠","🚅","✈️","🚀","🛸","🚁","🛶","🚤","🚢","🛳","🚓","🚛","🛵"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 9) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }

    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }

}
