//
//  PullRequest.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

public struct PullRequest {
    let id: Int
    let title: String
    let body: String
    let createdAt: String
    let owner: Owner
    
    public init(id: Int, title: String, body: String, createdAt: String, owner: Owner) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.owner = owner
    }
}
