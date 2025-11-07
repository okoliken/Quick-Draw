//
//  ShakeEffect.swift
//  Quick Draw
//
//  Created by Jeffery Okoli on 08/11/2025.
//

import SwiftUI


struct GameModel: Identifiable {
    var id: String
    var cardImage: String
    var rank: Int
}

struct ShakeEffect: GeometryEffect {
    var position: CGFloat // Represents the progress of the shake
    
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        // Use sin function to create a back-and-forth motion
        // Adjust amplitude and frequency as needed
        let translationX = -30 * sin(position * 2 * .pi)
        return ProjectionTransform(CGAffineTransform(translationX: translationX, y: 0))
    }
}

