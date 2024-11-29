//
//  Hashables.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI

//struct MyCustomModel: Identifiable {
//    let id:String = UUID().uuidString
//    let title:String
//} recommended

struct MyCustomModel: Hashable {
    
    let title:String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}


struct Hashables: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
//                ForEach(data, id:\.self) { item in
//                
//                    Text(item)
//                        .font(.headline)
//                    
//                }
                
                // identifiable
//                ForEach(data) { item in
//                
//                    Text(item.title)
//                        .font(.headline)
//                    
//                }
                
                ForEach(data, id: \.self) { item in
                
                    Text(item.hashValue.description)
                        .font(.headline)
                    
                }
            }
        }
    }
}

#Preview {
    Hashables()
}
