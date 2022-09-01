//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alp Erbil on 31.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
