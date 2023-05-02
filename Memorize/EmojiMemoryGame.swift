//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Theós on 27/04/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static private var themes: Array<MemoryGameTheme> = [
        MemoryGameTheme(name: "Vehicles", emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚎", "🛻", "🚛", "🚲", "🛵", "🏍️", "🛺", "🚟", "🚝", "✈️", "🛥️", "🚢", "🚖", "🚘", "🏎️", "🛫", "⛵️"], pairsToDisplay: 10, color: "red"),
        MemoryGameTheme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐼", "🐷", "🐮", "🐒", "🐥", "🦆", "🦉", "🐌"], pairsToDisplay: 12, color: "green"),
        MemoryGameTheme(name: "Fruits", emojis: ["🍏", "🍐", "🍊", "🍎", "🍋", "🍓", "🥭", "🍅", "🍒", "🥝", "🍇", "🍌", "🥑", "🥥", "🍍", "🍉"], pairsToDisplay: 5, color: "teal"),
        MemoryGameTheme(name: "Buildings", emojis: ["🛖", "⛺️", "🏠", "🏡", "🏤", "🏣", "🏦", "🏥", "💒", "🏩", "🏫", "🕌", "🕍", "⛪️", "🛕"], pairsToDisplay: 12, color: "blue"),
        MemoryGameTheme(name: "Flags", emojis: ["🇦🇫", "🇧🇭", "🇧🇸", "🇧🇾", "🇧🇹", "🇻🇬", "🇨🇲", "🇨🇽", "🇩🇰", "🇰🇲", "🇫🇮", "🇬🇩", "🇮🇩", "🇯🇵", "🇱🇹", "🇲🇩", "🇳🇪", "🇵🇼", "🇸🇦", "🇸🇰", "🇹🇿", "🇹🇳", "🇿🇼"], pairsToDisplay: 15, color: "orange"),
        MemoryGameTheme(name: "Tools", emojis: ["🪛", "🔧", "🔨", "⛏️", "🪚", "🧲", "🪓", "🪠", "⚒️", "🗜️"], pairsToDisplay: 15, color: "purple")
    ]
    
    static func createMemoryGame(with theme: MemoryGameTheme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.pairsToDisplay) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    static func selectTheme() -> MemoryGameTheme {
        themes.randomElement()!
    }
    
    @Published private var model: MemoryGame<String>
    private var theme: MemoryGameTheme
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeColor: Color {
        switch theme.color {
        case "yellow":
            return .yellow
        case "blue":
            return .blue
        case "brown":
            return .brown
        case "teal":
            return .teal
        case "red":
            return .red
        case "green":
            return .green
        case "gray", "grey":
            return .gray
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "cyan":
            return .cyan
        case "indigo":
            return .indigo
        default:
            return .accentColor
        }
    }
    
    var themeName: String {
        theme.name
    }
    
    var score: Int {
        model.score
    }
    
    init() {
        theme = EmojiMemoryGame.selectTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        theme = EmojiMemoryGame.selectTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
