//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alp Erbil on 28.08.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let themes = [
        MemoryGame.Theme(name: "Vehicles", content: ["🚗", "⛵️", "🚜", "🚲", "🚕", "🚌", "🚁", "🛶", "🛸", "🚒", "🚖", "🛴"], numOfPairsToShow: 6, themeColor: "red"),
        MemoryGame.Theme(name: "Barn Animals", content: ["🐔", "🐥", "🐮", "🐷", "🐭", "🐑", "🐖", "🐓"], numOfPairsToShow: 5, themeColor: "yellow"),
        MemoryGame.Theme(name: "Faces", content: ["👳‍♂️", "👩‍🦰", "👨🏽", "🧑🏿‍🦲", "👩🏻‍🦱", "👴", "👱🏽‍♀️", "👶🏻", "👦🏼", "🧔🏻", "👧🏽", "👱🏻‍♂️", "👵🏻", "🧓🏾"], numOfPairsToShow: 7, themeColor: "blue"),
        MemoryGame.Theme(name: "Bugs", content: ["🐝", "🐛", "🦋", "🐞", "🐜", "🦟", "🦗", "🕷", "🦂", "🐌"], numOfPairsToShow: 8, themeColor: "green"),
        MemoryGame.Theme(name: "Flags", content: ["🇳🇴", "🇸🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇬🇧", "🇮🇪", "🇨🇦"], numOfPairsToShow: 8, themeColor: "purple"),
        MemoryGame.Theme(name: "Halloween", content: ["👻", "🎃", "🕷", "🦇", "💀"], numOfPairsToShow: 10, themeColor: "orange")
    ]

    
    static func createMemoryGame() -> MemoryGame<String> {
        // select a random theme
        let theme = themes.randomElement()!
        let shuffledEmojis = Array(Set(theme.content.shuffled()))
        let maxCount = shuffledEmojis.count > theme.numOfPairsToShow ? theme.numOfPairsToShow : shuffledEmojis.count
        let number = Int.random(in: 3..<maxCount)
        return MemoryGame<String>(numberOfPairsOfCards: number, themeName: theme.name, themeColor: theme.themeColor) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }

    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeName: String {
        model.name
    }
    
    var themeColor: Color {
        switch model.color {
        case "red": return Color.red
        case "yellow": return Color.yellow
        case "blue": return Color.blue
        case "green": return Color.green
        case "purple": return Color.purple
        case "orage": return Color.orange
        default:
            return Color.black
        }
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        self.model = EmojiMemoryGame.createMemoryGame()
    }

}
