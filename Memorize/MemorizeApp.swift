//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alp Erbil on 31.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
