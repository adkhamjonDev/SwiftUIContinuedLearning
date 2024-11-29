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
    
    @Published var savedFruits: [Fruit] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores{ (description,error) in
            if let error = error {
                print("Error loading persistance data \(error.localizedDescription)")
            } else {
                print("Successfully loaded core data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<Fruit>(entityName: "Fruit")
        
        do {
            savedFruits = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
        
    }
    
    func addFruit(text:String) {
        let newFruit = Fruit(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving \(error.localizedDescription)")
        }
    }
    func deleteFruit(index:IndexSet) {
        guard let index = index.first else {return}
        let entitiy = savedFruits[index]
        container.viewContext.delete(entitiy)
        saveData()
        
    }
    
    func updateFruit(fruit:Fruit) {
        let currentName = fruit.name ?? ""
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
    
}


struct Coredata: View {
    
    @StateObject var viewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Add fruit here...",text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(
                    action: {
                        addNewFruit(fruit: textFieldText)
                    },
                    label: {
                        Text("Button")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.pink)
                            .cornerRadius(10)
                            
                    }
                )
                .disabled(textFieldText.isEmpty)
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.savedFruits) { fruit in
                    
                        Text(fruit.name ?? "NO NAME")
                            .onTapGesture {
                                viewModel.updateFruit(fruit: fruit)
                            }
                        
                    }
                    .onDelete(perform: viewModel.deleteFruit)
                }
                .listStyle(PlainListStyle())
                
                Spacer()
                    
            }
            .navigationTitle("Fruits")
        }
    }
    
    private func addNewFruit(fruit:String) {
        viewModel.addFruit(text: fruit)
        textFieldText = ""
    }
}

#Preview {
    Coredata()
}
