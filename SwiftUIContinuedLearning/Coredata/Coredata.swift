//
//  Coredata.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores{ (description,error) in
            if let error = error {
                print("Error loading persistance data \(error.localizedDescription)")
            }
        }
    }
    
}


struct Coredata: View {
    
    @StateObject var viewModel = CoreDataViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    Coredata()
}
