//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Theós on 02/05/2023.
//

import Foundation


struct MemoryGameTheme {
    var name: String
    var emojis: Array<String>
    var pairsToDisplay: Int {
        didSet {
            pairsToDisplay = min(pairsToDisplay, emojis.count)
        }
    }
    var color: String
    
    init(name: String, emojis: Array<String>, pairsToDisplay: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.pairsToDisplay = min(pairsToDisplay, emojis.count)
        self.color = color
    }
    
//    EXTRA CREDIT 1: create Init to enable default display of all emojis
    init(name: String, emojis: Array<String>, color: String) {
        self.init(name: name, emojis: emojis, pairsToDisplay: emojis.count, color: color)
    }
    
//    EXTRA CREDIT 2: Enable random pairs count.
    init(name: String, emojis: Array<String>, color: String, randomPairCount: Bool) {
        if randomPairCount {
            self.init(name: name, emojis: emojis, pairsToDisplay: Int.random(in: 5...30), color: color)
        } else {
            self.init(name: name, emojis: emojis, color: color)
        }
    }
}
