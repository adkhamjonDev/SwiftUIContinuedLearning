//
//  SortFilterMap.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 29/11/24.
//

import SwiftUI


struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class UserViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    
    @Published var filteredUsers: [UserModel] = []
    
    @Published var mappedUsers: [String] = []
    
    init() {
        getUsers()
        updateFilteredUsers()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "User - 1", points: 5, isVerified: true)
        let user2 = UserModel(name: nil, points: 0, isVerified: false)
        let user3 = UserModel(name: "User - 3", points: 20, isVerified: true)
        let user4 = UserModel(name: "User - 4", points: 50, isVerified: false)
        let user5 = UserModel(name: "User - 5", points: 33, isVerified: false)
        let user6 = UserModel(name: nil, points: 4, isVerified: true)
        let user7 = UserModel(name: "User - 7", points: 1, isVerified: false)
        let user8 = UserModel(name: "User - 8", points: 22, isVerified: false)
        let user9 = UserModel(name: "User - 9", points: 35, isVerified: true)
        let user10 = UserModel(name: "User - 10", points: 8, isVerified: false)
    
        users.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
        
    }
    
    func updateFilteredUsers() {
        // sort
        // filter
        // map
        
// MARK: SORT
//        filteredUsers = users.sorted { (user1, user2) -> Bool in
//            return user1.points > user2.points
//        }
        
//        filteredUsers = users.sorted(by: { $0.points > $1.points }) // $0 -> user 1
 
// MARK: FILTER
        
//        filteredUsers = users.filter({ (user) -> Bool in
//            //return user.points > 10
//            return user.isVerified
//            //return user.name.contains("2")
//        })
        
//        filteredUsers = users.filter({ $0.isVerified })
 
// MARK: MAP
        
//        mappedUsers = users.map({ (user) -> String in
//            user.name
//            //return user.name
//        })
//        mappedUsers = users.map{ user -> String in
//            user.name
//        }
//        
//        mappedUsers = users.map({ $0.name })
        
        mappedUsers = users.compactMap({ (user) -> String? in
            return user.name
        })
        
        //mappedUsers = users.compactMap({ $0.name })

        
    }
    
}


struct SortFilterMap: View {
    
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(viewModel.mappedUsers, id:\.self) { user in
                    
                    Text(user)
                        .font(.title)
                    
                }
                
                
//                ForEach(viewModel.filteredUsers) { user in
//                
//                    VStack(alignment: .leading) {
//                     
//                        Text(user.name)
//                        
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                        
//                    }
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    SortFilterMap()
}
