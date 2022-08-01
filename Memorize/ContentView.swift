//
//  ContentView.swift
//  Memorize
//
//  Created by Alp Erbil on 31.07.2022.
//

import SwiftUI

struct themes {
    static let vehicleTheme = ["🚗","🚌","🚑","🚜","🛴","🚲","🚔","🛺","🚘","🚃","🚄","🚠","🚅","✈️","🚀","🛸","🚁","🛶","🚤","🚢","🛳","🚓","🚛","🛵"]
    static let partyTheme = ["🥳", "🎈", "🍺", "🎂", "🍾", "🍸", "🧁", "🎉"]
    static let foodTheme = ["🍈", "🍇", "🥞", "🥨", "🧇", "🍗", "🍔", "🍕", "🧆"]
}

struct ContentView: View {
    @State var selectedTheme = themes.vehicleTheme
    var body: some View {
        VStack {
            Spacer()
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(selectedTheme.shuffled(), id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit) // id: \.self is here since ForEach requires the elements to be Identifiable. id: \.self makes them self-identifying.
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            HStack {
                Spacer()
                vehicleTheme
                Spacer()
                partyTheme
                Spacer()
                foodTheme
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
    }
    
    var vehicleTheme: some View {
        Button {
            self.selectedTheme = themes.vehicleTheme
        } label: {
            VStack {
                Image(systemName: "car").font(.largeTitle)
                Text("Vehicles")
            }
        }
    }
    
    var partyTheme: some View {
        Button {
            self.selectedTheme = themes.partyTheme
        } label: {
            VStack {
                Image(systemName: "person.3").font(.largeTitle)
                Text("Party")
            }
        }
    }
    
    var foodTheme: some View {
        Button {
            self.selectedTheme = themes.foodTheme
        } label: {
            VStack {
                Image(systemName: "fork.knife").font(.largeTitle)
                Text("Foods")
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}

