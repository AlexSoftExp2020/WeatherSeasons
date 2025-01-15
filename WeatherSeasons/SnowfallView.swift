//
//  SnowfallView.swift
//  WeatherSeasons
//
//  Created by Oleksii on 14.01.2025.
//

import SwiftUI

struct SnowfallEffectView: View {
    @State private var snowflakes: [Snowflake] = []
    private let numberOfSnowflakes = 150
    private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.blue.opacity(0.3) // Background color for the snow scene
                .edgesIgnoringSafeArea(.all)

            ForEach(snowflakes) { snowflake in
                Circle()
                    .frame(width: snowflake.size, height: snowflake.size)
                    .foregroundColor(.white.opacity(snowflake.opacity))
                    .position(x: snowflake.x, y: snowflake.y)
            }
        }
        .onAppear {
            initializeSnowflakes()
        }
        .onReceive(timer) { _ in
            updateSnowflakes()
        }
    }

    private func initializeSnowflakes() {
        snowflakes = (0..<numberOfSnowflakes).map { _ in
            Snowflake(
                id: UUID(),
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: -UIScreen.main.bounds.height...0),
                size: CGFloat.random(in: 2...8),
                speed: Double.random(in: 4...10),
                opacity: Double.random(in: 0.5...1.0),
                drift: CGFloat.random(in: -1...1)
            )
        }
    }

    private func updateSnowflakes() {
        for index in snowflakes.indices {
            // Update y position
            snowflakes[index].y += CGFloat(snowflakes[index].speed / 2)

            // Apply drift for natural movement
            snowflakes[index].x += snowflakes[index].drift

            // Reset snowflake if it moves out of view
            if snowflakes[index].y > UIScreen.main.bounds.height {
                snowflakes[index].y = -10 // Reset above the screen
                snowflakes[index].x = CGFloat.random(in: 0...UIScreen.main.bounds.width) // Randomize x position
            }
        }
    }
}

struct Snowflake: Identifiable {
    let id: UUID
    var x: CGFloat
    var y: CGFloat
    let size: CGFloat
    let speed: Double
    let opacity: Double
    let drift: CGFloat
}

struct SnowfallEffectView_Previews: PreviewProvider {
    static var previews: some View {
        SnowfallEffectView()
    }
}
