//
//  ContentView.swift
//  Memorize
//
//  Created by Theós on 06/04/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚎", "🛻", "🚛", "🚲", "🛵", "🏍️", "🛺", "🚟", "🚝", "✈️", "🛥️", "🚢", "🚖", "🚘", "🏎️", "🛫", "⛵️"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    let shape =
    RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        ZStack {
            if isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
