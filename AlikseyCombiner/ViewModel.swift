//
//  ViewModel.swift
//  AlikseyCombiner
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import Combine

struct Model {
    let title: String
    let count: Int
}

final class ViewModel: ObservableObject {
    typealias ModelRequest = (Endpoint) -> AnyPublisher<[Post], Error>

    private let modelRequest: ModelRequest
    private var cancellable: Set<AnyCancellable> = .init()
    
    @Published private(set) var posts: [Post] = .init()
    
    
    //MARK: - init(_:)
    init(modelRequest: @escaping ModelRequest) {
        self.modelRequest = modelRequest
        
        
    }
    
    func viewDidLoad() {
        modelRequest(.posts)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$posts)
    }
    
    func viewDidDisapper() {
        cancellable.removeAll()
    }
}
