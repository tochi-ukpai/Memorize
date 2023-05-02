//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Theós on 27/04/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
//    EXTRA CREDIT 2: Randomise display count for "Vehicles", and "Flags" theme.
    static private var themes: Array<MemoryGameTheme> = [
        MemoryGameTheme(name: "Vehicles", emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚎", "🛻", "🚛", "🚲", "🛵", "🏍️", "🛺", "🚟", "🚝", "✈️", "🛥️", "🚢", "🚖", "🚘", "🏎️", "🛫", "⛵️"], color: "red", randomPairCount: true),
        MemoryGameTheme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐼", "🐷", "🐮", "🐒", "🐥", "🦆", "🦉", "🐌"], pairsToDisplay: 12, color: "green"),
        MemoryGameTheme(name: "Fruits", emojis: ["🍏", "🍐", "🍊", "🍎", "🍋", "🍓", "🥭", "🍅", "🍒", "🥝", "🍇", "🍌", "🥑", "🥥", "🍍", "🍉"], pairsToDisplay: 5, color: "teal"),
        MemoryGameTheme(name: "Buildings", emojis: ["🛖", "⛺️", "🏠", "🏡", "🏤", "🏣", "🏦", "🏥", "💒", "🏩", "🏫", "🕌", "🕍", "⛪️", "🛕"], color: "blue"), // Create with default to all emojis
        MemoryGameTheme(name: "Flags", emojis: ["🇦🇫", "🇧🇭", "🇧🇸", "🇧🇾", "🇧🇹", "🇻🇬", "🇨🇲", "🇨🇽", "🇩🇰", "🇰🇲", "🇫🇮", "🇬🇩", "🇮🇩", "🇯🇵", "🇱🇹", "🇲🇩", "🇳🇪", "🇵🇼", "🇸🇦", "🇸🇰", "🇹🇿", "🇹🇳", "🇿🇼"], color: "orange", randomPairCount: true),
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
    
//    EXTRA CREDIT 3: Support gradient theme color
    var themeColor: LinearGradient {
        switch theme.color {
        case "yellow":
            return LinearGradient(colors: [.accentColor, .yellow], startPoint: .top, endPoint: .bottom)
        case "blue":
            return LinearGradient(colors: [.accentColor, .blue], startPoint: .top, endPoint: .bottom)
        case "brown":
            return LinearGradient(colors: [.accentColor, .brown], startPoint: .top, endPoint: .bottom)
        case "teal":
            return LinearGradient(colors: [.accentColor, .teal], startPoint: .top, endPoint: .bottom)
        case "red":
            return LinearGradient(colors: [.accentColor, .red], startPoint: .top, endPoint: .bottom)
        case "green":
            return LinearGradient(colors: [.accentColor, .green], startPoint: .top, endPoint: .bottom)
        case "gray", "grey":
            return LinearGradient(colors: [.accentColor, .gray], startPoint: .top, endPoint: .bottom)
        case "orange":
            return LinearGradient(colors: [.accentColor, .orange], startPoint: .top, endPoint: .bottom)
        case "purple":
            return LinearGradient(colors: [.accentColor, .purple], startPoint: .top, endPoint: .bottom)
        case "pink":
            return LinearGradient(colors: [.accentColor, .pink], startPoint: .top, endPoint: .bottom)
        case "cyan":
            return LinearGradient(colors: [.accentColor, .cyan], startPoint: .top, endPoint: .bottom)
        case "indigo":
            return LinearGradient(colors: [.accentColor, .indigo], startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(colors: [.mint, .accentColor], startPoint: .top, endPoint: .bottom)
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
