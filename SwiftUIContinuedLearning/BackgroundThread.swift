//
//  BackgroundThread.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    
    func fetchData() {
        
        //DispatchQueue.global().async{
        DispatchQueue.global(qos: .background).async{

            let newData = self.downloadData()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 1: \(Thread.current)")
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 2: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
        }
        
       
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print("\(x)")
        }
        return data
    }
    
}


struct BackgroundThread: View {
    
    @StateObject private var viewModel = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load data".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        viewModel.fetchData()
                    }
                
                ForEach(viewModel.dataArray, id:\.self) { data in
                    
                    Text(data)
                        .font(.headline)
                        .foregroundColor(.red)
                    
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    BackgroundThread()
}
