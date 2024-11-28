//
//  DragGestureMoveDragSwipe.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 28/11/24.
//

import SwiftUI

struct DragGestureMoveDragSwipe: View {
    
    @State var offset:CGSize = .zero
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    
    @State var currentDragOffsetY: CGFloat = 0
    @State var enfingOffsetY: CGFloat = 0
    var body: some View {
        
//        VStack {
//            Text("\(offset.width)")
//            Spacer()
//        }
//        
//        RoundedRectangle(cornerRadius: 20)
//            .frame(width: 300, height: 500)
//            .offset(offset)
//            .scaleEffect(getScaleAmount())
//            .rotationEffect(Angle(degrees: getRotationAmount()))
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        withAnimation(.spring()){
//                            offset = value.translation
//                        }
//                    }
//                    .onEnded { value in
//                        withAnimation(.spring()){
//                            offset = .zero
//                        }
//                    }
//            )
        
        // MARK: SECTION 2
        
        ZStack {
            Color.green.ignoresSafeArea()
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: enfingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    enfingOffsetY = -startingOffsetY
                                } else if enfingOffsetY != 0 && currentDragOffsetY > 150 {
                                    currentDragOffsetY = 0
                                    enfingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
            
            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureMoveDragSwipe()
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("This is the description for our app. This is my favorite SwiftUI course and I recommend to all of my friends to subscribe to Swiftful Thinking!")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Create an accoint")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
