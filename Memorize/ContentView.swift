//
//  ContentView.swift
//  Memorize
//
//  Created by Theós on 06/04/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
     
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.themeName)
                Spacer()
                Button("New Game") {
                    viewModel.startNewGame()
                }
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, background: viewModel.themeColor)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                            .backgroundStyle(viewModel.themeColor)
                    }
                }
            }
            HStack {
                Spacer()
                Text("Score: \(viewModel.score)")
                Spacer()
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let background: LinearGradient // EXTRA CREDIT 3: Use Gradient rather than Color
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(background, lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }else {
                shape
                    .fill(background)
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            ContentView(viewModel: game)
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
        }
    }
}
