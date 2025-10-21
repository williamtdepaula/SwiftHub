//
//  PullRequestsAPI.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Foundation

enum PullRequestsAPI: NetworkEndPoint {
    
    case pullRequests(owner: String, repository: String, page: Int)
    
    var url: URL {
        switch self {
        case .pullRequests(let ownerId, let repositoryId, _):
            return  URL(string: "https://api.github.com/repos/\(ownerId)/\(repositoryId)/pulls")!
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .pullRequests(_, _, let page):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "state", value: "all"),
            ]
        }
    }
    
    
}
