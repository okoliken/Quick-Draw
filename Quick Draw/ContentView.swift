//
//  ContentView.swift
//  Quick Draw
//
//  Created by Jeffery Okoli on 07/11/2025.
//


import SwiftUI




struct ContentView: View {
    @State private var gameStore: Game
    @State private var numberOfShakes: Int = 0
    @State private var showWinnerOverlay: Bool = false
    @State private var winnerText: String = ""
    
    init() {
        let defaultCards: [GameModel] = [
            .init(id: UUID().uuidString, cardImage: "card2", rank: 2),
            .init(id: UUID().uuidString, cardImage: "card3", rank: 3),
            .init(id: UUID().uuidString, cardImage: "card4", rank: 4),
            .init(id: UUID().uuidString, cardImage: "card5", rank: 5),
            .init(id: UUID().uuidString, cardImage: "card6", rank: 6),
            .init(id: UUID().uuidString, cardImage: "card7", rank: 7),
            .init(id: UUID().uuidString, cardImage: "card8", rank: 8),
            .init(id: UUID().uuidString, cardImage: "card9", rank: 9),
            .init(id: UUID().uuidString, cardImage: "card10", rank: 10),
            .init(id: UUID().uuidString, cardImage: "card11", rank: 11),
            .init(id: UUID().uuidString, cardImage: "card12", rank: 12),
            .init(id: UUID().uuidString, cardImage: "card13", rank: 13),
            .init(id: UUID().uuidString, cardImage: "card14", rank: 14),
        ]
        _gameStore = State(wrappedValue: Game(playableCards: defaultCards))
    }
    
    init(gameStore: Game) {
        _gameStore = State(wrappedValue: gameStore)
    }
    
    var body: some View {
        ZStack(alignment: .center){
            Image("background-wood-cartoon")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            VStack(alignment: .center, spacing: 35){
                
                Image("logo")
                    .shake(shakes: numberOfShakes)
                
                CardContainerView(playerCard: gameStore.playerDeck[0], cpuCard: gameStore.cpuDeck[0])
                
                
                VStack {
                    Button(action: {
                        gameStore.startGame()
                        
                        withAnimation(.easeOut(duration: 0.2).repeatCount(4, autoreverses: true)) {
                            numberOfShakes += 1
                        }
                    }) {
                        Image("button")
                    }
                    .buttonStyle(.plain)
                    
                    if gameStore.playerScore > 0 || gameStore.cpuScore > 0 {
                        Button("Restart") {
                            gameStore.resetGame()
                        }
                        .font(.callout)
                    }

                }
                
                BottomScoreView(playerScore: gameStore.playerScore, cpuScore: gameStore.cpuScore)
                
                Spacer()
                
            }
            .padding(.top, 80)
        }
        .onChange(of: gameStore.playerScore) { _, newValue in
            if newValue >= 10 {
                winnerText = "Player Wins!"
                showWinnerOverlay = true
            }
        }
        .onChange(of: gameStore.cpuScore) { _, newValue in
            if newValue >= 10 {
                winnerText = "CPU Wins!"
                showWinnerOverlay = true
            }
        }
        .overlay {
            if showWinnerOverlay {
                ZStack {
                    Color.black.opacity(0.6).ignoresSafeArea()
                    VStack(spacing: 24) {
                        Text(winnerText)
                            .font(.largeTitle).bold()
                            .foregroundStyle(.white)
                            .shadow(radius: 10)
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200)
                            .shadow(radius: 10)
                        Button {
                            gameStore.resetGame()
                            showWinnerOverlay = false
                        } label: {
                            Text("Play Again")
                                .font(.headline)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.ultraThinMaterial)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                )
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding()
                }
                .transition(.opacity.combined(with: .scale))
                .animation(.spring(), value: showWinnerOverlay)
            }
        }
        
    }
}

#Preview {
    ContentView()
}



// EXTENDS ARRAY METHODS, SPLITS AN ARRAY IN TWO EQUAL HALF (I STOLE IT FROM GOODLE AI)🙂‍↔️
extension Array {
    func splitIntoHalves() -> (left: ArraySlice<Element>, right: ArraySlice<Element>) {
        let midIndex = count / 2
        let leftHalf = self[..<midIndex] // Elements from the beginning up to (but not including) midIndex
        let rightHalf = self[midIndex...] // Elements from midIndex to the end
        return (left: leftHalf, right: rightHalf)
    }
}

// THIS EXTENDS EVERY VIEW TO HAVE THIS SHAKE MODIFIER
extension View {
    func shake(shakes: Int) -> some View {
        modifier(ShakeEffect(position: CGFloat(shakes)))
    }
}

