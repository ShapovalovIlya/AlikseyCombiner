//
//  ApiManager.swift
//  AlikseyCombiner
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import Combine

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem] = .init()
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = ["/", path].joined()
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            preconditionFailure("Unable to create url from: \(components)")
        }
        return url
    }
    
    static let posts = Self(path: "posts")
    
}

/*
 [
   {
     "userId": 1,
     "id": 1,
     "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
     "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
   },
 */

struct Post: Codable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct ApiManager {
    typealias Response = (data: Data, response: URLResponse)
    let session: URLSession
    let decoder: JSONDecoder
    
    init() {
        self.session = URLSession(configuration: .default)
        self.decoder = .init()
    }
    
    func getRequest<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: endpoint.url)
            .tryMap(parse(response:))
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func parse(response: Response) throws -> Data {
        
        
        return response.data
    }
    
}
