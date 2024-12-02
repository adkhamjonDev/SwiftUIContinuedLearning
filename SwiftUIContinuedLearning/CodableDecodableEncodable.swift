//
//  CodableDecodableEncodable.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 30/11/24.
//

import SwiftUI

// Codable = Decodable + Encodable

struct CustomerModel: Identifiable,Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}


class CodableDecodableEncodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getdata()
    }
    
    func getdata() {
        guard let data = getJsonData() else { return }
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
        
        //        print("JSON DATA:")
        //        print(data)
        //        let jsonString = String(data: data, encoding: .utf8)
        //        print(jsonString)
        

//        do {
//            let newCustomer = try JSONDecoder().decode(CustomerModel.self, from: data)
//            self.customer = newCustomer
//            print(newCustomer)
//
//        } catch let error {
//            print("error \(error.localizedDescription)")
//            
//        }
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String:Any],
//            
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//            
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        
        
        
    }
    
    func getJsonData() -> Data? {

        let customer = CustomerModel(id: "111", name: "Emily", points: 100, isPremium: false)
        
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name" : "Joe",
//            "points" : 5,
//            "isPremium" : true
//        ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        print("\(jsonData)")
        
        return jsonData
        
    }
    
}


struct CodableDecodableEncodable: View {
    
    @StateObject var vm = CodableDecodableEncodableViewModel()
    
    var body: some View {
        VStack(spacing: 20.0) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableDecodableEncodable()
}
