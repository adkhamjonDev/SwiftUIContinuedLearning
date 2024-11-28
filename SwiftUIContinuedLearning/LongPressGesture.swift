//
//  LongPressGesture.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 28/11/24.
//

import SwiftUI

struct LongPressGesture: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    var body: some View {

        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            
            HStack {
                Text("Click here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)){
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = true
                                    }
                                }
                            })
                        }
                    } perform: {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
        
        //        Text(isComplete ? "COMPLETED" : "NOT COMPLETED")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? .green : .gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 5.0,maximumDistance: 50) {
//                isComplete.toggle()
//            }
    }
}

#Preview {
    LongPressGesture()
}
