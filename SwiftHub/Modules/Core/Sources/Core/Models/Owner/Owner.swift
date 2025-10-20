//
//  Owner.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

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
