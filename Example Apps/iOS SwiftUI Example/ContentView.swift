//
//  ContentView.swift
//  iOS SwiftUI Example
//
//  Created by Gong Zhang on 2021/11/26.
//

import SwiftUI
import SPConfetti

struct ContentView: View {
    
    @State private var isPresenting = false
    
    var body: some View {
        VStack {
            Button(action: { isPresenting.toggle() }) {
                Text(isPresenting ? "Stop" : "Start")
            }
        }
        .confetti(isPresented: $isPresenting,
                  animation: .fullWidthToDown,
                  particles: [.triangle, .arc, .heart],
                  duration: 1.0)
        .confettiParticle(\.velocity, 600)
        .confettiParticle(\.velocityRange, 200)
        .confettiParticle(\.birthRate, 100)
        .confettiParticle(\.spin, 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
