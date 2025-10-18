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
    }
}
