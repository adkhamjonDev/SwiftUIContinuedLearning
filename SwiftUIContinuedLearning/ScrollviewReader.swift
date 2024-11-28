//
//  ScrollviewReader.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 28/11/24.
//

import SwiftUI

struct ScrollviewReader: View {
    
    @State var textFieldText:String = ""
    @State var scrollToIndex:Int = 0
    
    var body: some View {
        VStack {
            
            
            TextField("Enter a number here...", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .cornerRadius(10)
                .keyboardType(.numberPad)
            
            
            Button("SCROLL NOW"){
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                    //proxy.scrollTo(30, anchor: .center)
            }
            
            ScrollView {
                
                ScrollViewReader { proxy in
                    
                 
                    
                    ForEach(0..<50) { index in
                        
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(10)
                            .id(index)
                        
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    ScrollviewReader()
}
