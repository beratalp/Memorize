//
//  ContentView.swift
//  Memorize
//
//  Created by Alp Erbil on 6.11.2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = [["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"],
                  ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🚚"],
                  ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇"]]

    
    @State var cardCount = 6
    @State var currentEmojiIndex = 0
    
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            themeButtons
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            let shuffledEmojis = emojis[currentEmojiIndex].shuffled().prefix(upTo: cardCount)
            let doubleShuffledEmojis = (shuffledEmojis + shuffledEmojis).shuffled()
            ForEach(doubleShuffledEmojis.indices, id: \.self) { index in
                CardView(content: doubleShuffledEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeButtons: some View {
        HStack {
            Spacer()
            Button(action: {
                currentEmojiIndex = 0
            }, label: {
                themeButtonStacker(text: "Halloween", image: "person.3")
            })
            Spacer()
            Button(action: {
                currentEmojiIndex = 1
            }, label: {
                themeButtonStacker(text: "Vehicles", image: "car.fill")
            })
            Spacer()
            Button(action: {
                currentEmojiIndex = 2
            }, label: {
                themeButtonStacker(text: "Faces", image: "face.smiling")
            })
            Spacer()
        }
    }
    
    func themeButtonStacker(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
            Text(text).font(.body)
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
