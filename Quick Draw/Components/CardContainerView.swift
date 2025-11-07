//
//  CardContainerView.swift
//  Quick Draw
//
//  Created by Jeffery Okoli on 08/11/2025.
//
import SwiftUI

struct CardContainerView: View {
    let playerCard: GameModel
    let cpuCard: GameModel
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 40){
            Image(playerCard.cardImage)
                .transition(.slide.animation(.easeInOut(duration: 0.3)))
                .animation(.bouncy, value: playerCard.id)
            Image(cpuCard.cardImage)
                .transition(.slide.animation(.easeInOut(duration: 0.3)))
                .animation(.bouncy, value: playerCard.id)
        }
        .animation(.spring(), value: playerCard.id)
        .animation(.spring(), value: cpuCard.id)
        .padding(25)
    }
}
