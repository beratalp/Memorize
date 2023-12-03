//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Alp Erbil on 20.11.2023.
//

import SwiftUI

struct MemoryGameTheme<CardContent> {
    let name: String
    let emojis: [CardContent]
    let numberOfPairsOfCards: Int
    let themeColor: Color
}
