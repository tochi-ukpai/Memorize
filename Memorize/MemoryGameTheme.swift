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
}
