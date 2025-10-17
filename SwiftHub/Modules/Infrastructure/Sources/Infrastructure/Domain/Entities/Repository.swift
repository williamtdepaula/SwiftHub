//
//  Repository.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

struct Repository {
    let id: Int
    let name: String
    let starsCount: Int
    let forksCount: Int
    let description: String?
    let owner: Owner
    
    struct Owner {
        let id: Int
        let userName: String
        let avatarStringUrl: String
    }
}
