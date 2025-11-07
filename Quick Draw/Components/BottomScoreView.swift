//
//  BottomScoreView.swift
//  Quick Draw
//
//  Created by Jeffery Okoli on 08/11/2025.
//

import SwiftUI

struct BottomScoreView: View {
    
    let playerScore: Int
    let cpuScore: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 80) {
            VStack(alignment: .center, spacing: 20) {
                Text("PLAYER")
                    .foregroundStyle(.white)
                    .font(.callout.bold())
                
                Text(playerScore.description)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
            
            
            VStack(alignment: .center, spacing: 20) {
                Text("CPU")
                    .foregroundStyle(.white)
                    .font(.callout.bold())
                
                Text(cpuScore.description)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
            
        }
        .padding()
    }
}
