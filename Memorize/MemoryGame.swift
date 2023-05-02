//
//  MemoryGame.swift
//  Memorize
//
//  Created by Theós on 27/04/2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    match(card: chosenIndex)
                    match(card: potentialMatchIndex)
                } else {
                    seen(card: chosenIndex)
                    seen(card: potentialMatchIndex)
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    private mutating func seen(card cardIndex: Int) {
        if cards[cardIndex].isSeen {
            score -= 1
        } else {
            cards[cardIndex].isSeen = true
        }
        cards[cardIndex].seenCount += 1 // EXTRA CREDIT 4: increase number of times card has been seen
    }
    
//    EXTRA CREDIT 4: Deduct reward points per matched card based on number of times card has been seen
    private mutating func match(card cardIndex: Int) {
        score += max(3 - cards[cardIndex].seenCount, 1)
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // Add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var seenCount: Int = 0 // EXTRA CREDIT 4: Track number of times card has been seen
        var content: CardContent
        var id: Int
    }
}
