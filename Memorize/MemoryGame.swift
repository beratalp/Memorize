//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Alp Erbil on 18.11.2023.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var theme: MemoryGameTheme<CardContent>
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, theme gameTheme: MemoryGameTheme<CardContent>, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // Add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
        self.theme = gameTheme
    }
    
    var indexOfTheOneAnyOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { return cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAnyOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        // if any of the cards are seen before, decrease the score by 1
                        if cards[chosenIndex].isSeen {
                            score -= 1
                        } else {
                            cards[chosenIndex].isSeen = true
                        }
                        if cards[potentialMatchIndex].isSeen {
                            score -= 1
                        } else {
                            cards[potentialMatchIndex].isSeen = true
                        }
                    }
                } else {
                    indexOfTheOneAnyOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        var id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmatched")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
