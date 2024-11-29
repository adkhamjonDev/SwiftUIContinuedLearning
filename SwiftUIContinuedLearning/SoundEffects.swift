//
//  SoundEffects.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI
import AVKit // audio video kit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "relaxing", withExtension: ".mp3") else { return }
        
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()

        } catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}

struct SoundEffects: View {
    
    
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Play Sound 1") {
                SoundManager.instance.playSound()
            }
            
            Button("Play Sound 2") {
                SoundManager.instance.stopSound()
            }
        }
    }
}

#Preview {
    SoundEffects()
}
