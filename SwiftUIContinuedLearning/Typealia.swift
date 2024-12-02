//
//  Typealia.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI


struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel


struct Typealia: View {
    
    //@State var item: MovieModel = MovieModel(title: "Title", director: "Director", count: 10)
    @State var item: TVModel = TVModel(title: "TV Title", director: "TV Director", count: 10)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
        .font(.headline)
    }
}

#Preview {
    Typealia()
}
