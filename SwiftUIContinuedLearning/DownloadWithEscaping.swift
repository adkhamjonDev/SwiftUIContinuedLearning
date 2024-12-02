//
//  DownloadWithEscaping.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 30/11/24.
//

import SwiftUI


struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class DownloadWithEscapingViewmModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromUrl: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data ) else { return }
                
                DispatchQueue.main.async{ [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("no DATA")
            }
        }
        
        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            guard
//                let data = data,
//                error == nil,
//                let response = response as? HTTPURLResponse,
//                response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Error downloading data \(error)")
//                return
//                
//            }
////            print("Successfully downloaded data!")
////            print(data)
////            let jsonString = String(data: data, encoding: .utf8)
////            print(jsonString)
//            
//            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data ) else { return }
//            
//            DispatchQueue.main.async{ [weak self] in
//                self?.posts.append(newPost)
//            }
//            
//            
//        }
//        .resume()
        
    }
    
    func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data \(error)")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        .resume()
    }
    
}


struct DownloadWithEscaping: View {
    
    @StateObject private var vm = DownloadWithEscapingViewmModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                
            
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                
            }
        }
    }
}

#Preview {
    DownloadWithEscaping()
}
