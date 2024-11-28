//
//  RotateGesture.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 28/11/24.
//

import SwiftUI

struct RotateGesture: View {
    
    @State private var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

#Preview {
    RotateGesture()
}
