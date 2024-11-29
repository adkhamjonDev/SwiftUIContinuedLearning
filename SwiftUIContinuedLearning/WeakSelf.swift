//
//  WeakSelf.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI

struct WeakSelf: View {
    
    @AppStorage("count") var count:Int?
    
    init() {
        count = 0
    }
    
    
    var body: some View {
        NavigationStack {
            NavigationLink(
                "Navigate",
                destination: WeakSelfSecondScreen()
            )
            .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
                
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var viewModel = WekSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View ")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = viewModel.data {
                Text(data)
            }
        }
    }
}

class WekSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount+1, forKey: "count")
        getData()
    }
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount-1, forKey: "count")
    }
    
    func getData() {
        // string reference dinit not calling viewmodel do not destroying
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500){
//            self.data = "NEW DATA!!!" // string reference
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500){ [weak self] in
            self?.data = "NEW DATA!!!" // string reference
        }
    }
}

#Preview {
    WeakSelf()
}
