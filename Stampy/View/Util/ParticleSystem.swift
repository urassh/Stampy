//
//  ParticleSystem.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var todoDone: Bool = false
}

struct ParticleSystem: View {
    let emojis = ["👍", "👏", "❤️", "🔥", "👀", "🎉", "👊", "🤝"]
    @State private var particles: [Particle] = []
    @State private var count: Int = 0
    @Binding var todoDone: Bool
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // パーティクル
            ForEach(particles) { particle in
                Text(particle.emoji)
                    .font(.system(size: 100))
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .onChange(of: todoDone) {
            count = 0
        }
        .onReceive(timer) { _ in
            count += 1
            
            if todoDone && count % 5 == 0 {
                createParticle()
            }
            
            updateParticles()
        }
    }
    
    private func createParticle() {
        let particle = Particle(
            emoji: emojis.randomElement() ?? "✨",
            position: CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: UIScreen.main.bounds.height + 50
            ),
            velocity: CGPoint(
                x: CGFloat.random(in: -50 ... 50),
                y: CGFloat.random(in: -300 ... -200)
            ),
            opacity: 1.0
        )
        particles.append(particle)
    }
    
    private func updateParticles() {
        particles = particles.compactMap { particle in
            var updatedParticle = particle
            
            // 位置の更新
            updatedParticle.position.x += particle.velocity.x * 0.03
            updatedParticle.position.y += particle.velocity.y * 0.03
            
            // 不透明度の更新
            updatedParticle.opacity -= 0.003
            
            // 画面外に出たパーティクルや完全に透明になったパーティクルは削除
            if updatedParticle.position.y < -50 || updatedParticle.opacity <= 0 {
                return nil
            }
            
            return updatedParticle
        }
    }
}

struct Particle: Identifiable {
    let id = UUID()
    let emoji: String
    var position: CGPoint
    let velocity: CGPoint
    var opacity: Double
}
