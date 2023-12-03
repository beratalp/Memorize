//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alp Erbil on 18.11.2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes = [
        MemoryGameTheme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"], numberOfPairsOfCards: 10, themeColor: .orange),
        MemoryGameTheme(name: "Summer", emojis: ["🌞", "🍉", "🏖️", "🍦", "🏄‍♂️", "🌊", "🕶️", "👙", "🍹", "🐚"], numberOfPairsOfCards: 8, themeColor: .yellow),
        MemoryGameTheme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁"], numberOfPairsOfCards: 10, themeColor: .green),
        MemoryGameTheme(name: "Food", emojis: ["🍕", "🍔", "🍟", "🌭", "🥪", "🌮", "🍣", "🍜", "🍲", "🍩", "🍪"], numberOfPairsOfCards: 9, themeColor: .red),
        MemoryGameTheme(name: "Sports", emojis: ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🏉", "🏓", "🏸", "🥊", "🚴‍♂️"], numberOfPairsOfCards: 8, themeColor: .blue),
        MemoryGameTheme(name: "Travel", emojis: ["✈️", "🚂", "🚗", "🛳️", "🗽", "🗼", "🏰", "🏝️", "🗺️", "🎒", "🧳"], numberOfPairsOfCards: 10, themeColor: .pink)
    ]
    
    var currentThemeColor: Color {
        get {
            return model.theme.themeColor
        }
    }
    
    var currentThemeName: String {
        get {
            return model.theme.name
        }
    }
    
    var currentScore: Int {
        get {
            return model.score
        }
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        // select a random theme
        let theme = themes.randomElement()!
        var emojis = theme.emojis
        emojis.shuffle()
        return MemoryGame(numberOfPairsOfCards: 11, theme: theme) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        self.model = EmojiMemoryGame.createMemoryGame()
        // shuffle the model
        self.model.shuffle()
    }
}
