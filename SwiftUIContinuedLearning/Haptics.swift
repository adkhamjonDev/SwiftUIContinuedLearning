//
//  Haptics.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI

class HapticManager {
    
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct Haptics: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Notification Success") {
                HapticManager.instance.notification(type: .success)
            }
            Button("Notification Warning") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("Notification Error") {
                HapticManager.instance.notification(type: .error)
            }
            
            Divider()
            
            Button("Haptic Soft") {
                HapticManager.instance.impact(style: .soft)
            }
            Button("Haptic Light") {
                HapticManager.instance.impact(style: .light)
            }
            Button("Haptic Medium") {
                HapticManager.instance.impact(style: .medium)
            }
            
            Button("Haptic Rigid") {
                HapticManager.instance.impact(style: .rigid)
            }
            
            Button("Haptic Heavy") {
                HapticManager.instance.impact(style: .heavy)
            }
        }
    }
}

#Preview {
    Haptics()
}
