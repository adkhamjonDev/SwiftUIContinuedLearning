//
//  PublishersAndSubscribersInCombine.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 02/12/24.
//

import SwiftUI
import Combine


class PublishersAndSubscribersInCombineViewModel: ObservableObject {
    
    @Published var count: Int = 0
    
    //var timer:AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var textField: String = ""
    @Published var textIsValid: Bool = false
    
    init() {
        setUpTimer()
        addtextFieldSubscriber()
    }
    
    func addtextFieldSubscriber() {
        $textField
            .map { (string) -> Bool in
                if string.count > 3 {
                    return true
                } else {
                    return false
                }
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            //.assign(to: \.textIsValid, on: self)
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
      Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                guard let self = self else { return }
                self.count+=1
                
//                if let count = self.count, count >= 10 {
////                    self.timer?.cancel()
//                    for item in cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
}



struct PublishersAndSubscribersInCombine: View {
    
    @StateObject private var vm = PublishersAndSubscribersInCombineViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            TextField("Type here something", text: $vm.textField)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    
                    , alignment: .trailing
                )
        }
        .padding()
    }
}

#Preview {
    PublishersAndSubscribersInCombine()
}
