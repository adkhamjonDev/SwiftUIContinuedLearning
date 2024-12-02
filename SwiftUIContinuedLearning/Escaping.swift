//
//  Escaping.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI


class EscapingViewModel: ObservableObject {
    
    
    @Published var text: String = "Hello"
    
    
    func getData() {
//        downloadData3 { [weak self] (data) in
//            self?.text = data
//        }
        downloadData4 { [weak self] (data) in
            self?.text = data.data
        }
    }
    
    func downloadData() -> String {
        return "New Data"
    }
   
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        
        completionHandler("NEW DATA!")
        
    }
    // closure adding as parameter another function to inside function
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("NEW DATA!")
        }
        // make code async
        
        
    }
    
    
    func downloadData4(completionHandler: @escaping (_ data: DownloadResult) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let downloadData = DownloadResult(data: "NEW DATA!!!")
            completionHandler(downloadData)
        }
        // make code async
        
        
    }
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let downloadData = DownloadResult(data: "NEW DATA!!!")
            completionHandler(downloadData)
        }
        // make code async
        
        
    }
}

struct DownloadResult {
    let data: String
}

typealias  DownloadCompletion = (DownloadResult) -> ()

struct Escaping: View {
    
    @StateObject private var viewModel = EscapingViewModel()
    
    var body: some View {

        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                viewModel.getData()
            }

    }
}

#Preview {
    Escaping()
}
