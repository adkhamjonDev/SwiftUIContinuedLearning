//
//  MultipleSheets.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 28/11/24.
//

import SwiftUI


struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 - Binding
// 2 - use multiple .sheets
// 3 - use $item
struct MultipleSheets: View {
    
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    @State var selectedModel: RandomModel?=nil
    var body: some View {
        VStack(spacing: 20.0) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
            }
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
            }
        }
        .sheet(item: $selectedModel) { item in
            NextScreen(selectedModel: item)
        } // 2nd step
    }
}

// 1st solution
//struct NextScreen: View {
//    
//    @Binding var selectedModel: RandomModel
//    
//    var body: some View {
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}

struct NextScreen: View {
    
    var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheets()
}
