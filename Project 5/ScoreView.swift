//
//  ScoreView.swift
//  Project 5
//
//  Created by christian de angelo orozco on 11/4/24.
//

import SwiftUI

struct ScoreView: View {
    let score: Int
    let playAgainAction: () -> Void  // Closure to handle play again
    
    var body: some View {
        VStack {
            Text("Your Score")
                .font(.largeTitle)
            
            Text("\(score)")
                .font(.system(size: 60, weight: .bold))
            
            Button("Play Again") {
                playAgainAction()  // Call the play again action
            }
            .padding()
        }
    }
}


