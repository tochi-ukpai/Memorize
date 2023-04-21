//
//  ContentView.swift
//  Memorize
//
//  Created by Theós on 06/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State var theme: Theme = .vehicles
    @State var emojis: ArraySlice<String> = Theme.vehicles.emojis[...]
    
    var cardWidth: CGFloat {
        switch emojis.count {
        case 0...4:
            return 162.5
        case 5..<10:
            return 108
        case 10...16:
            return 84
        default:
            return 65
        }
    }
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.title)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            HStack {
                Spacer()
                ChangeThemeBtn(theme: .vehicles, changeTheme: {
                    theme = .vehicles
                    emojis = theme.emojis.shuffled()[0..<Int.random(in: 4...theme.emojis.count)]
                })
                Spacer()
                ChangeThemeBtn(theme: .buildings, changeTheme: {
                    theme = .buildings
                    emojis = theme.emojis.shuffled()[0..<Int.random(in: 4...theme.emojis.count)]
                })
                Spacer()
                ChangeThemeBtn(theme: .flags, changeTheme: {
                    theme = .flags
                    emojis = theme.emojis.shuffled()[0..<Int.random(in: 4...theme.emojis.count)]
                })
                Spacer()
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
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

enum Theme: String {
    case vehicles = "Vehicles"
    case buildings = "Buildings"
    case flags = "Flags"
    
    var emojis: [String] {
        switch self {
        case .flags:
            return ["🏳️‍⚧️", "🇺🇳", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇮", "🇦🇴", "🇦🇩", "🇦🇼", "🇦🇺", "🇧🇿", "🇧🇦", "🇧🇫", "🇮🇨", "🇨🇳", "🇹🇩", "🇨🇰", "🇨🇷", "🇨🇮", "🇨🇾"]
        case .buildings:
            return ["🏚️", "🏢", "🏬", "🏣", "🏤", "🏛️", "💒", "🏨", "🏦", "🏪", "🏥", "🏘️", "🏠", "🛖", "⛺️", "🏕️", "🏡"]
        case .vehicles:
            return ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚎", "🛻", "🚛", "🚲", "🛵", "🏍️", "🛺", "🚟", "🚝", "✈️", "🛥️", "🚢", "🚖", "🚘", "🏎️", "🛫", "⛵️"]
        }
    }
    
    var icon: String {
        switch self {
        case .flags:
            return "flag"
        case .buildings:
            return "house"
        case .vehicles:
            return "car"
        }
    }
}

struct ChangeThemeBtn: View {
    var theme: Theme
    var changeTheme: () -> Void
    
    var body: some View {
        Button {
            changeTheme()
        } label: {
            VStack {
                Image(systemName: theme.icon)
                Text(theme.rawValue)
                    .font(.caption)
            }
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
