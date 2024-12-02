//
//  DownloadWithCombine.swift
//  SwiftUIContinuedLearning
//
//  Created by Adkhamjon Rakhimov on 02/12/24.
//

import SwiftUI
import Combine

class DownloadWithCombineViewModel: ObservableObject{
    
    @Published var posts: [PostModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
  
        // COMBINE DISCUSSION
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. recieve the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. cancellable at any time!!
        
        // 1. create publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap ( check data is good)
        // 5. Decode ( decode data into Post )
        // 6. sink ( put the item into our app )
        // 7. store ( cancel subscription if needed )
        
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background)) // no need this line
            .receive(on: DispatchQueue.main)
//            .tryMap { (data,response) -> Data in
//                guard
//                    let res = response as? HTTPURLResponse,
//                    res.statusCode >= 200 && res.statusCode < 300 else {
//                    throw URLError(URLError.badServerResponse)
//                }
//                return data
//            }
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            //.replaceError(with: [])
            .sink { (completion) in
                print("completion \(completion )")
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let res = output.response as? HTTPURLResponse,
            res.statusCode >= 200 && res.statusCode < 300 else {
            throw URLError(URLError.badServerResponse)
        }
        return output.data
    }
    
}


struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
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
    DownloadWithCombine()
}
