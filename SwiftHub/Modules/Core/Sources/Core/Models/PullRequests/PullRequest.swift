//
//  PullRequest.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

public struct PullRequest: Sendable {
    public let id: Int
    public let title: String
    public let body: String
    public let createdAt: String
    public let user: Owner
    
    public init(id: Int, title: String, body: String, createdAt: String, user: Owner) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.user = user
    }
}
