//
//  Repository.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

public struct Repository: Sendable {
    public let id: Int
    public let name: String
    public let starsCount: Int
    public let forksCount: Int
    public let description: String?
    public let owner: Owner
    
    public struct Owner: Sendable {
        public let id: Int
        public let userName: String
        public let avatarStringUrl: String
        
        public init(id: Int, userName: String, avatarStringUrl: String) {
            self.id = id
            self.userName = userName
            self.avatarStringUrl = avatarStringUrl
        }
    }
    
    public init(id: Int, name: String, starsCount: Int, forksCount: Int, description: String?, owner: Owner) {
        self.id = id
        self.name = name
        self.starsCount = starsCount
        self.forksCount = forksCount
        self.description = description
        self.owner = owner
    }
}
