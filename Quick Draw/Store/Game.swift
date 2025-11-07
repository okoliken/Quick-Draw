//
//  Game.swift
//  Quick Draw
//
//  Created by Jeffery Okoli on 08/11/2025.
//
import SwiftUI

@Observable class Game {
    var playableCards: [GameModel]
    var playerScore: Int = 0
    var cpuScore: Int = 0
    
    var playerDeck: [GameModel] = [.init(id: UUID().uuidString, cardImage: "back", rank: 0)]
    var cpuDeck: [GameModel] = [.init(id: UUID().uuidString, cardImage: "back", rank: 0)]
    
    
    init(playableCards: [GameModel]) {
        self.playableCards = playableCards
    }
    
    func shuffleCardsAndSplitInHalf() -> (player: [GameModel], cpu: [GameModel]) {
        let shuffleCards = self.playableCards.shuffled()
        
        let splitShuffledCardsInTwo = shuffleCards.splitIntoHalves()
        
        return (Array(splitShuffledCardsInTwo.0), Array(splitShuffledCardsInTwo.1))
    }
    
    func startGame() {
        let (playerDeck, cpuDeck) = self.shuffleCardsAndSplitInHalf()
        
        self.playerDeck = playerDeck
        self.cpuDeck = cpuDeck
        
        
        if self.playerDeck[0].rank > self.cpuDeck[0].rank {
            self.playerScore += 1
        }
        
        if self.cpuDeck[0].rank > self.playerDeck[0].rank {
            self.cpuScore += 1
        }
        
    }
    
    func resetGame() {
        self.playerScore = 0
        self.cpuScore = 0
        
        self.playerDeck = [.init(id: UUID().uuidString, cardImage: "back", rank: 0)]
        self.cpuDeck = [.init(id: UUID().uuidString, cardImage: "back", rank: 0)]
    }
}
