//
//  RepositoryAPI.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation

enum RepositoryAPI: NetworkEndPoint {
    case mostPopularSwiftRepositories(page: Int)
    
    var url: URL {
        switch self {
        case .mostPopularSwiftRepositories:
            URL(string: "https://api.github.com/search/repositories")!
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .mostPopularSwiftRepositories(let page):
            return [
                URLQueryItem(name: "q", value: "language:swift"),
                URLQueryItem(name: "sort", value: "stars"),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }
    
    
}
